import 'package:flutter/material.dart';
import 'package:flutter_js/flutter_js.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  late JavascriptRuntime _jsRuntime;
  TextEditingController _sessionController = TextEditingController();
  bool _isReady = false;

  @override
  void initState() {
    super.initState();
    _initJSRuntime();
  }

  Future<void> _initJSRuntime() async {
    _jsRuntime = getJavascriptRuntime();
    setState(() {
      _isReady = true;
    });
  }

  Future<void> _executeCheckout() async {
    if (_isReady) {
      String jsCode = """
        // Your JavaScript code here
        // Use the checkout() function
        checkout({
          sessionToken: "${_sessionController.text}",
          merchantSiteId: "<your merchantSiteId>",
          merchantId: "<your merchantId>",
          // Add other parameters here
        });
      """;
      _jsRuntime.evaluate(jsCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: _isReady
          ? SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _sessionController,
                    decoration: InputDecoration(labelText: 'Session Token'),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _executeCheckout,
                    child: Text('Proceed to Checkout'),
                  ),
                ],
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }

  @override
  void dispose() {
    _sessionController.dispose();
    _jsRuntime?.dispose();
    super.dispose();
  }
}