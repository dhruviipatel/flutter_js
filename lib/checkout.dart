import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_js/flutter_js.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  late JavascriptRuntime _jsRuntime;
  final TextEditingController _sessionController = TextEditingController();
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
      String checkoutJS = await rootBundle.loadString('assets/checkout.js');

      final result = _jsRuntime.evaluate('''${checkoutJS}checkout();''');
      print(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: _isReady
          ? SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _executeCheckout,
                    child: const Text('Proceed to Checkout'),
                  ),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  @override
  void dispose() {
    _sessionController.dispose();
    _jsRuntime.dispose();
    super.dispose();
  }
}
