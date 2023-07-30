import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/styles/styles.dart';
import '../../../../../core/widgets/appbar_generic.dart';
import '../../../../../core/widgets/button.dart';
import '../../../../core/util/api_basehelper.dart';
import '../../../../core/util/navigator.dart';
import '../../../../injection_container.dart';
import '../../../auth/presentation/cubit/on_boarding_cubit/on_boarding_cubit.dart';
import '../../../auth/presentation/widgets/language_widget.dart';

List<String> language = ['العربية', 'English'];

class ChangeLanguageScreen extends StatefulWidget {
  const ChangeLanguageScreen({super.key});

  @override
  State<ChangeLanguageScreen> createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  @override
  Widget build(BuildContext context) {
    EasyLocalization.of(context)!.currentLocale == Locale("en")
        ? context.read<OnBoardingCubit>().setLanguageIsSelected = 1
        : context.read<OnBoardingCubit>().setLanguageIsSelected = 0;
    return Scaffold(
      appBar: AppBarGeneric(
        title: tr("language"),
        titleColor: textColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 42.h,
              ),
              BlocBuilder<OnBoardingCubit, OnBoardingState>(
                builder: (context, state) {
                  return SizedBox(
                    height: 200.h,
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 2,
                        itemBuilder: ((context, index) => Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              child: LanguageWidget(
                                borderColor: context
                                            .watch<OnBoardingCubit>()
                                            .languageIsSelected ==
                                        index
                                    ? primary
                                    : textColor,
                                backGroundColor: context
                                            .watch<OnBoardingCubit>()
                                            .languageIsSelected ==
                                        index
                                    ? transparent
                                    : white,
                                text: language[index],
                                onTap: () {
                                  // setState(() {
                                  // });
                                  context
                                      .read<OnBoardingCubit>()
                                      .setLanguageIsSelected = index;
                                },
                              ),
                            ))),
                  );
                },
              ),
              GenericButton(
                onPressed: () {
                  if (context.read<OnBoardingCubit>().languageIsSelected == 0) {
                    setState(() {
                      context.setLocale(Locale("ar"));

                      sl<ApiBaseHelper>().updateLocalInHeaders("ar");
                    });
                  } else {
                    setState(() {
                      context.setLocale(Locale("en"));
                      sl<ApiBaseHelper>().updateLocalInHeaders("en");
                    });
                  }

                  sl<AppNavigator>().pop();
                },
                child: Text(
                  tr("save"),
                  style: TextStyles.textViewSemiBold16.copyWith(color: white),
                ),
                borderRadius: BorderRadius.circular(15.sp),
                color: primary,
                width: 336.w,
              )
            ],
          ),
        ),
      ),
    );
  }
}
