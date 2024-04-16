import 'package:flutter/material.dart';
import 'package:test_js/checkout.dart';
import 'package:test_js/checkout1.dart';
import 'package:test_js/checkout2.dart';
import 'package:test_js/checkout3.dart';
import 'package:test_js/menu.dart';
import 'package:test_js/snackbartest.dart';
import 'package:test_js/webviewcheck.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: CheckoutPage2());
  }
}
