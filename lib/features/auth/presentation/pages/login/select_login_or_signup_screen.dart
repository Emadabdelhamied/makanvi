import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:makanvi_web/features/auth/presentation/pages/intro/on_boarding_screen.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/styles/styles.dart';
import '../../../../../core/util/navigator.dart';
import '../../../../../core/widgets/button.dart';
import '../../../../../injection_container.dart';
import '../intro/select_country_screen.dart';

class SelectLoginOrSignupScreen extends StatelessWidget {
  const SelectLoginOrSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: Center(
        child: Container(
          height: 210.h,
          child: Image.asset("assets/icons/icon_splash.png"),
        ),
      ),
      bottomNavigationBar: Container(
        // color: black,
        height: 150.h,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            GenericButton(
              onPressed: () {
                sl<AppNavigator>().pushToFirst(
                    screen: SelectCountryScreen(
                  isDirect: true,
                ));
              },
              child: Text(
                tr("login_splash"),
                style: TextStyles.textViewSemiBold16.copyWith(color: white),
              ),
              borderColor: white,
              color: transparentColor,
              width: double.infinity,
              borderRadius: BorderRadius.circular(15.r),
            ),
            SizedBox(
              height: 15.h,
            ),
            GenericButton(
              onPressed: () {
                sl<AppNavigator>().push(screen: OnBoardingScreen());
              },
              child: Text(
                tr("sign_up"),
                style: TextStyles.textViewSemiBold16.copyWith(color: primary),
              ),
              borderColor: white,
              color: white,
              width: double.infinity,
              borderRadius: BorderRadius.circular(15.r),
            )
          ],
        ),
      ),
    );
  }
}
