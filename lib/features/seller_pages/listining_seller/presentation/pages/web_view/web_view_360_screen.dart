// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// import '../../../../../../core/constant/colors/colors.dart';
// import '../../../../../../core/util/navigator.dart';
// import '../../../../../../core/widgets/appbar_generic.dart';
// import '../../../../../../injection_container.dart';

// class WebView360Screen extends StatefulWidget {
//   const WebView360Screen({super.key, required this.url, required this.title});
//   final String url;
//   final String title;

//   @override
//   State<WebView360Screen> createState() => _WebView360ScreenState();
// }

// class _WebView360ScreenState extends State<WebView360Screen> {
//   late final WebViewController controller;

//   @override
//   void initState() {
//     super.initState();

//     // #docregion webview_controller
//     controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(const Color(0x00000000))
//       ..addJavaScriptChannel(
//         'Toaster',
//         onMessageReceived: (JavaScriptMessage message) {
//           log(message.message.toString());
//         },
//       )
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {},
//           onPageStarted: (String url) {
//             log(url.toString());
//           },
//           onPageFinished: (String url) async {
//             final response = await controller.runJavaScriptReturningResult(
//                 "document.documentElement.innerText");

//             log(url.toString());
//             log(response.toString());
//           },
//           onWebResourceError: (WebResourceError error) {},
//           onNavigationRequest: (NavigationRequest request) {
//             log(request.url.toString());
//             if (request.url.contains('success')) {
//               log(request.url);
//               return NavigationDecision.navigate;
//             }
//             log(request.url);

//             return NavigationDecision.navigate;
//           },
//         ),
//       )
//       ..loadRequest(Uri.parse(widget.url));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBarGeneric(
//           title: widget.title,
//           titleColor: textColor,
//           onPressed: () {
//             sl<AppNavigator>().pop();
//           },
//         ),
//         body: SafeArea(child: WebViewWidget(controller: controller)));
//   }
// }
