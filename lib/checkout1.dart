import 'package:flutter/material.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class CheckoutPage1 extends StatefulWidget {
  const CheckoutPage1({Key? key}) : super(key: key);

  @override
  _CheckoutPage1State createState() => _CheckoutPage1State();
}

class _CheckoutPage1State extends State<CheckoutPage1> {
  late WebViewControllerPlus _controler;

  String htmlstring = '''

<!DOCTYPE HTML>
<html>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<head>
    <title>webview_flutter_plus</title>
    <!-- <link crossorigin="anonymous" href="style.css" rel="stylesheet"> -->
</head>
<body>
<div id="testDiv">
    webview_flutter_plus is an extension of webview_flutter to load HTML, CSS and Javascript even from Assets or String.
    <br>
    <br>
    <br>
    Please tap the text to see Javascript execution.
</div>

<script src="assets/script.js"></script>
</body>
</html>

''';

  @override
  void initState() {
    _controler = WebViewControllerPlus()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadRequest(Uri.parse('https://flutter.dev'));
    // ..loadFlutterAsset('assets/index.html');
    //..loadHtmlString(htmlstring);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('webview_flutter_plus Example'),
        ),
        body: WebViewWidget(controller: _controler));
  }

  @override
  void dispose() {
    _controler.server.close();
    super.dispose();
  }
}
