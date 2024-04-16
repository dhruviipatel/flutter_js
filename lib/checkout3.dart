import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class CheckoutPage3 extends StatefulWidget {
  const CheckoutPage3({Key? key}) : super(key: key);

  @override
  _CheckoutPage3State createState() => _CheckoutPage3State();
}

class _CheckoutPage3State extends State<CheckoutPage3> {
  late WebViewControllerPlus _controler;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadHtml();
  }

  _loadHtml() async {
    String htmlContent = await _loadHtmlFile();

    setState(() {
      _controler = WebViewControllerPlus()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..loadHtmlString(htmlContent);
      _isLoading = false;
    });
  }

  Future<String> _loadHtmlFile() async {
    String htmlContent = await rootBundle.loadString('assets/payment.html');

    htmlContent = htmlContent.replaceFirst('</head>', '''
      <script src="https://cdn.safecharge.com/safecharge_resources/v1/websdk/safecharge.js"></script>
      <script>
        var sfc = SafeCharge({
          env: 'int',
          merchantId: '2950421966619096832',
          sessionToken: "9a3e9300-3c80-4cde-ba8c-bf5717d10e84",
          merchantSiteId: '246018',
        });
        window.sfc = sfc
        var ScFields = sfc.fields({
          fonts: [{
            cssUrl: 'https://fonts.googleapis.com/css?family=Source+Code+Pro'
          }],
          locale: 'en'
        });

        var ScFieldStyles = {
          base: {
            color: '#32325D',
            fontWeight: 500,
            fontFamily: 'Roboto, Consolas, Menlo, monospace',
            fontSize: '16px',
            fontSmoothing: 'antialiased',
            '::placeholder': {
              color: '#CFD7DF',
            },
            ':-webkit-autofill': {
              color: '#e39f48',
            },
          },
          invalid: {
            color: '#E25950',
            '::placeholder': {
              color: '#FFCCA5',
            },
          },
        };
        var ScFieldClasses = {
          focus: 'focused',
          empty: 'empty',
          invalid: 'invalid',
          complete: 'complete',
        };

        var style = {
          base: {
            fontFamily: 'Roboto, sans-serif',
            color: "#045d47",
            fontSize: "14px",
            fontSmoothing: 'antialiased',
            '::placeholder': {
              color: '#00becf'
            }
          },
          invalid: {
            color: '#e5312b',
            ':focus': {
              color: '#303238'
            }
          },
          empty: {
            color: '#00becf',
            '::placeholder': {
              color: '#00becf'
            }
          },
          valid: {
            color: '#00A86b'
          }
        };

        var scard = ScFields.create('ccNumber', {
          style: ScFieldStyles,
          classes: ScFieldClasses,
        });
        scard.attach('#card-number');

        var cardExpiry = ScFields.create('ccExpiration', {
          style: ScFieldStyles,
          classes: ScFieldClasses,
        });
        cardExpiry.attach('#card-expiry');

        var cardCvc = ScFields.create('ccCvc', {
          style: ScFieldStyles,
          classes: ScFieldClasses,
        });
        cardCvc.attach('#card-cvc');

        function main() {
          document.getElementById('result').innerHTML = '';

          sfc.createPayment({
            "userTokenId": "230811147",
            "clientUniqueId": "695701003", // optional
            "cardHolderName": document.getElementById('cardHolderName').value,
            "paymentOption": scard,
            "billingAddress": {
              "email": "someone@somedomain.com",
              "country": "GB"
            }
          }, function (res) {
            console.log(res);
            document.getElementById('result').innerHTML = JSON.stringify(res, null, 4)
          })
        }
      </script>
      </head>
      ''');

    return htmlContent;
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Nuvei payment example'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Nuvei payment example'),
        ),
        body: _controler != null
            ? WebViewWidget(controller: _controler)
            : Center(
                child: Text('Failed to load web view'),
              ),
      );
    }
  }

  @override
  void dispose() {
    _controler.server.close();
    super.dispose();
  }
}
