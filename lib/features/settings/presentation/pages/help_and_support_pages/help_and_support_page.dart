import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/icons.dart';
import '../../../../../core/util/navigator.dart';
import '../../../../../core/widgets/appbar_generic.dart';
import '../../../../../injection_container.dart';
import '../../widgets/settings_widget.dart';
import 'email_us_pages.dart';

class HelpAndSupportPage extends StatelessWidget {
  const HelpAndSupportPage({super.key});
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGeneric(
        title: tr("help_and_support"),
        titleColor: textColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Container(
                  height: 180.h,
                  width: MediaQuery.of(context).size.width,
                  // color: red,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SettingsWidget(
                          icon: emailUsSvg,
                          text: tr("email_us"),
                          onTap: () {
                            sl<AppNavigator>().push(screen: EmailUsPage());
                          },
                          subText: tr("send_us_inquires_on_email")),
                      SettingsWidget(
                          icon: callUsSvg,
                          text: tr("call_us"),
                          onTap: () {
                            _makePhoneCall("+0097313304406");
                          },
                          subText: tr("call_us_directly_on_our_hotline")),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
