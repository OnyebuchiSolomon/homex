// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
//
// class PaymentWebView extends StatelessWidget {
//   final String url;
//   const PaymentWebView({super.key, required this.url});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Complete Payment")),
//       backgroundColor: Colors.white,
//       body: InAppWebView(
//         initialUrlRequest: URLRequest(url: WebUri(url)),
//         onLoadStop: (controller, uri) {
//           if (uri != null && uri.toString().contains("payment-complete")) {
//             // ✅ Payment finished, close the webview
//             Navigator.pop(context, true);
//           }
//         },
//       ),
//     );
//   }
// }
