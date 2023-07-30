import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../login/select_login_or_signup_screen.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/styles/styles.dart';
import '../../../../../core/util/navigator.dart';
import '../../../../../core/widgets/appbar_generic.dart';
import '../../../../../core/widgets/button.dart';
import '../../../../../injection_container.dart';
import '../../widgets/language_widget.dart';

List<String> language = ['English', 'العربية'];

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  int _languageIsSelected = 0;

  @override
  Widget build(BuildContext context) {
    EasyLocalization.of(context)!.currentLocale == Locale("en")
        ? _languageIsSelected = 0
        : _languageIsSelected = 1;
    return Scaffold(
      appBar: AppBarGeneric(
        isback: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 25.h,
              ),
              Text(
                tr("select_lang"),
                style: TextStyles.textViewSemiBold14.copyWith(color: black),
              ),
              SizedBox(
                height: 42.h,
              ),
              // BlocBuilder<OnBoardingCubit, OnBoardingState>(
              //   builder: (context, state) {
              //     return

              SizedBox(
                height: 200.h,
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 2,
                    itemBuilder: ((context, index) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: LanguageWidget(
                            borderColor: _languageIsSelected == index
                                ? primary
                                : textColor,
                            backGroundColor: _languageIsSelected == index
                                ? transparent
                                : white,
                            text: language[index],
                            onTap: () {
                              // setState(() {
                              index == 1
                                  ? context.setLocale(Locale("ar"))
                                  : context.setLocale(Locale("en"));
                              // });
                              _languageIsSelected = index;
                            },
                          ),
                        ))),
              ),
              // },
              // )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
          padding:
              EdgeInsets.only(bottom: 35.h, right: 20.w, left: 20.w, top: 20.h),
          child: GenericButton(
            onPressed: () {
              sl<AppNavigator>().push(screen: SelectLoginOrSignupScreen());
            },
            child: Text(
              tr("select"),
              style: TextStyles.textViewSemiBold16.copyWith(color: white),
            ),
            borderRadius: BorderRadius.circular(15.sp),
            color: primary,
            width: 336.w,
          )),
    );
  }
}
