import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../../../core/util/navigator.dart';
import '../../../../../core/widgets/appbar_generic.dart';
import '../../../../../injection_container.dart';
import '../../../../settings/presentation/pages/package_and_payment_page.dart/package_payment_page.dart';
import '../pages/plan_payment_page.dart';

class PaymentScreen extends StatelessWidget {
  final String paymentUrl;
  final String? purpose;
  final String? target;
  final int? listingId;
  final bool isPackagePage;

  const PaymentScreen({
    Key? key,
    required this.paymentUrl,
    this.purpose,
    this.target,
    this.listingId,
    required this.isPackagePage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        isPackagePage == true
            ? sl<AppNavigator>().pushToFirst(screen: PackageAndPaymentPage())
            : sl<AppNavigator>().pushToFirst(
                screen: PalnPaymentPage(
                listingId: listingId,
                target: target,
                purpose: purpose,
              ));
        return true;
      },
      child: Scaffold(
        appBar: AppBarGeneric(
          title: "",
          onPressed: () {
            isPackagePage == true
                ? sl<AppNavigator>()
                    .pushToFirst(screen: PackageAndPaymentPage())
                : sl<AppNavigator>().pushToFirst(
                    screen: PalnPaymentPage(
                    listingId: listingId,
                    target: target,
                    purpose: purpose,
                  ));
          },
        ),
        body: SafeArea(
            child: InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(paymentUrl)),
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
              useShouldOverrideUrlLoading: true,
            ),
            ios: IOSInAppWebViewOptions(
              enableViewportScale: true,
            ),
            android: AndroidInAppWebViewOptions(
              // useHybridComposition: true,
              useWideViewPort: false,
              // initialScale: 2,
              // it makes 2 times bigger
            ),
          ),
          shouldOverrideUrlLoading: (controller, navigationAction) async {
            final url = navigationAction.request.url.toString();

            if (url.contains("SUCCESSFUL")) {
              return NavigationActionPolicy.CANCEL;
            } else if (url.contains("fail")) {
              return NavigationActionPolicy.CANCEL;
            }

            return NavigationActionPolicy.ALLOW;
          },
        )
            // WebView(
            //   initialUrl: paymentUrl,
            //   javascriptMode: JavascriptMode.unrestricted,
            //   navigationDelegate: (NavigationRequest request) {
            //     print(request.url);
            //     if (request.url.contains("succes")) {
            //       print("success");
            //       // bloc.addToWallet(amount!);
            //       showToast(
            //         tr("success_pay"),
            //       );
            //       Get.offAll(() => const MainScreen());
            //       print('blocking navigation to $request}');
            //       return NavigationDecision.prevent;
            //     } else if (request.url.contains("fail")) {
            //       // Get.offAll(()=>MainScreen());
            //       print("fail");
            //       showToast(
            //         tr("error_pay"),
            //       );
            //     }
            //     print('allowing navigation to $request');
            //     return NavigationDecision.navigate;
            //   },
            // ),
            ),
      ),
    );
  }
}
