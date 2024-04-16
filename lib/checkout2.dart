import 'package:flutter/material.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class CheckoutPage2 extends StatefulWidget {
  const CheckoutPage2({Key? key}) : super(key: key);

  @override
  _CheckoutPage2State createState() => _CheckoutPage2State();
}

class _CheckoutPage2State extends State<CheckoutPage2> {
  late WebViewControllerPlus _controler;

  @override
  void initState() {
    _controler = WebViewControllerPlus()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadFlutterAsset('assets/checkout.html');
    //..loadFlutterAsset('assets/createPayment.html');

    //..loadFlutterAssetServer('')
    //..loadFlutterAsset('assets/payment.html');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Nuvei payment example'),
        ),
        body: WebViewWidget(controller: _controler));
  }

  @override
  void dispose() {
    _controler.server.close();
    super.dispose();
  }
}
