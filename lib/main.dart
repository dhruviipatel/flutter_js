import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_js/flutter_js.dart';
import 'package:test_js/checkout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test JS',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CheckoutPage(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final number = ValueNotifier(0);
    final JavascriptRuntime jsRuntime = getJavascriptRuntime();
    return Scaffold(
      body: Center(
        child: ValueListenableBuilder(
            valueListenable: number,
            builder: (_, value, __) {
              return Text(value.toString());
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            final result = await addFromJs(jsRuntime, number.value, 1);
            number.value = result;
          } on PlatformException catch (e) {
            print('error: ${e.details}');
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

Future<int> addFromJs(
    JavascriptRuntime jsRuntime, int firstno, int secondno) async {
  String jsData = await rootBundle.loadString('assets/jsfile.js');
  final result = jsRuntime.evaluate("""${jsData}add($firstno, $secondno)""");

  final jsstringresult = result.stringResult;

  return int.parse(jsstringresult);
}
