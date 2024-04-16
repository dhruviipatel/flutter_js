import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_js/flutter_js.dart';

class PaymentGateway extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  PaymentGateway({super.key});

  @override
  _PaymentGatewayState createState() => _PaymentGatewayState();
}

class _PaymentGatewayState extends State<PaymentGateway> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FlutterJsHomeScreen(),
    );
  }
}

class FlutterJsHomeScreen extends StatefulWidget {
  const FlutterJsHomeScreen({super.key});

  @override
  _FlutterJsHomeScreenState createState() => _FlutterJsHomeScreenState();
}

class _FlutterJsHomeScreenState extends State<FlutterJsHomeScreen> {
  String _jsResult = '';

  final JavascriptRuntime javascriptRuntime =
      getJavascriptRuntime(forceJavascriptCoreOnAndroid: false);

  String? _quickjsVersion;

  Future<String> evalJS() async {
    JsEvalResult jsResult = await javascriptRuntime.evaluateAsync(
      """
const initCheckout = () => {
  const onResult = function(result) {
    console.log(result)
    console.log('Final callback data received by caller', JSON.stringify(result))
  }

  /*
     CHECKOUT INITIALIZARION 
     ---------------------------------------
  */
  checkout({
    env: 'test', //prod for production
    renderTo: '.container_for_checkout', 
    //credentials
    sessionToken: '2c634074-d9b5-460b-832c-15617dc1adb9',
    merchantSiteId: '2950421966619096832',
    merchantId: '246018',
    //amount and currency for presentation purposes
    currency: 'EUR',
    amount: 135,
    //basic settings
    country: 'DE',
    locale: 'en',
    fullName: 'CL-BRW1', //simulates 3DS challenge, FL-BRW1 will simulate frictionless
    email: 'integration@nuvei.com',

    onResult: onResult, //with this callback you will recieve the transaction outcome and can react to it

    // optional UI settings
    payButton: "amountButton",
    showResponseMessage: true,
    autoOpenPM: true,
    alwaysCollectCvv: false,

    logLevel: 0,
    // i18n : {
    //     my_methods : "Meine Zahlungsmethoden*"
    // },
    fieldStyle: {
      "base": {
        "iconColor": "#c4f0ff",
        "color": "#6b778c",
        "fontWeight": 400,
        "fontFamily": "Nunito Sans",
        "fontSize": "18px",
        "fontSmoothing": "antialiased",
        ":-webkit-autofill": {
          "color": "#ffffff"
        },
        "::placeholder": {
          "color": "#6b778c" // default one picked from chrome
        }
      },
      "invalid": {
        "iconColor": "#FFC7EE",
        "color": "#FFC7EE"
      }
    }
  })
}

            """,
      // sourceUrl: 'script.js',
    );
    javascriptRuntime.executePendingJob();
    JsEvalResult asyncResult = await javascriptRuntime.handlePromise(jsResult);
    return asyncResult.stringResult;
  }

  @override
  void initState() {
    super.initState();
    // javascriptRuntime.setInspectable(true);
    javascriptRuntime.onMessage('getDataAsync', (args) async {
      await Future.delayed(const Duration(seconds: 1));
      final int count = args['count'];
      Random rnd = Random();
      final result = <Map<String, int>>[];
      for (int i = 0; i < count; i++) {
        result.add({'key$i': rnd.nextInt(100)});
      }
      return result;
    });
    javascriptRuntime.onMessage('asyncWithError', (_) async {
      await Future.delayed(const Duration(milliseconds: 100));
      return Future.error('Some error');
    });
  }

  @override
  void dispose() {
    javascriptRuntime.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JS inside WebView'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'JS Evaluate Result:\n\n$_jsResult\n',
              textAlign: TextAlign.center,
            ),
            // const SizedBox(
            //   height: 20,
            // ),
            // const Padding(
            //   padding: EdgeInsets.all(10),
            //   child: Text(
            //       'Click on the big JS Yellow Button to evaluate the expression bellow using the flutter_js plugin'),
            // ),
            // const Padding(
            //   padding: EdgeInsets.all(8.0),
            //   child: Text(
            //     "Math.trunc(Math.random() * 100).toString();",
            //     style: TextStyle(
            //         fontSize: 12,
            //         fontStyle: FontStyle.italic,
            //         fontWeight: FontWeight.bold),
            //   ),
            // ),
            // ElevatedButton(
            //   onPressed: () => Navigator.of(context).push(
            //     MaterialPageRoute(
            //       builder: (ctx) => PaymentPage(
            //         //widget.javascriptRuntime,
            //           javascriptRuntime),
            //     ),
            //   ),
            //   child: const Text('See Ajv Example'),
            // ),
            // SizedBox.fromSize(size: const Size(double.maxFinite, 20)),
            // ElevatedButton(
            //   child: const Text('Fetch Remote Data'),
            //   onPressed: () async {
            //     var asyncResult = await javascriptRuntime.evaluateAsync("""
            //     fetch('https://raw.githubusercontent.com/abner/flutter_js/master/FIXED_RESOURCE.txt').then(response => response.text());
            //   """);
            //     javascriptRuntime.executePendingJob();
            //     final promiseResolved =
            //     await javascriptRuntime.handlePromise(asyncResult);
            //     var result = promiseResolved.stringResult;
            //     setState(() => _quickjsVersion = result);
            //   },
            // ),
            Text(
              'QuickJS Version\n${_quickjsVersion ?? '<NULL>'}',
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        //backgroundColor: Colors.transparent,
        // child: Image.asset('assets/js.ico'),
        onPressed: () async {
          final result = await evalJS();
          if (!mounted) return;
          setState(() {
            _jsResult = result;
          });
        },
      ),
    );
  }
}
