import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/images.dart';
import '../../../../../core/constant/styles/styles.dart';
import '../../../../../core/util/navigator.dart';
import '../../../../../core/widgets/button.dart';
import '../../../../../core/widgets/error_screen.dart';
import '../../../../../core/widgets/loading.dart';
import '../../../../../injection_container.dart';
import '../../../domain/entities/on_boarding_entity.dart';
import '../../cubit/on_boarding_cubit/on_boarding_cubit.dart';
import 'select_country_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool isLast = false;
  int itemIndex = 0;
  var pageContraller = PageController();
  List images = [firstOnBoardImage, secondOnBoardImage, thirdOnBoardImage];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<OnBoardingCubit>()..fGetOnBoardingData(),
      child: Scaffold(
        body: BlocConsumer<OnBoardingCubit, OnBoardingState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is OnBoardingLoading) {
              return Center(
                child: Loading(),
              );
            }
            if (state is OnBoardingSuccess) {
              return Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          images[itemIndex],
                        ))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  child: Column(
                    children: [
                      Expanded(
                        child: PageView.builder(
                          physics: BouncingScrollPhysics(),
                          controller: pageContraller,
                          onPageChanged: (int index) {
                            setState(() {
                              itemIndex = index;
                            });
                            if (index == state.data.onboards.length - 1) {
                              setState(() {
                                isLast = true;
                              });
                            } else {
                              setState(() {
                                isLast = false;
                              });
                            }
                          },
                          itemBuilder: (context, index) => Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Spacer(),
                                Text(
                                  '${state.data.onboards[index].title}',
                                  style: TextStyles.textViewSemiBold16
                                      .copyWith(color: textColor),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  '${state.data.onboards[index].description}',
                                  textAlign: TextAlign.center,
                                  style: TextStyles.textViewMedium12
                                      .copyWith(color: textColor),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                SmoothPageIndicator(
                                  controller: pageContraller,
                                  count: state.data.onboards.length,
                                  effect: ExpandingDotsEffect(
                                      activeDotColor: primary,
                                      dotColor: secondry,
                                      dotHeight: 10,
                                      dotWidth: 10,
                                      spacing: 5,
                                      expansionFactor: 3),
                                ),
                              ],
                            ),
                          ),
                          itemCount: state.data.onboards.length,
                        ),
                      ),
                      SizedBox(
                        height: 0.h,
                      ),
                      (isLast || state.data.onboards.isEmpty)
                          ? Padding(
                              padding: EdgeInsets.only(
                                  bottom: 35.h,
                                  right: 15.w,
                                  left: 15.w,
                                  top: 15.h),
                              child: GenericButton(
                                onPressed: () {
                                  sl<AppNavigator>()
                                      .push(screen: SelectCountryScreen());
                                },
                                child: Text(
                                  tr("get_started"),
                                  style: TextStyles.textViewSemiBold16
                                      .copyWith(color: white),
                                ),
                                borderRadius: BorderRadius.circular(15.sp),
                                color: primary,
                                width: 336.w,
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.only(
                                  bottom: 35.h,
                                  right: 15.w,
                                  left: 15.w,
                                  top: 15.h),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      sl<AppNavigator>()
                                          .push(screen: SelectCountryScreen());
                                    },
                                    child: Container(
                                      height: 50.h,
                                      // width: 128.w,
                                      decoration: BoxDecoration(
                                          // color: white,
                                          borderRadius:
                                              BorderRadius.circular(15.r)),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15.w),
                                        child: Center(
                                          child: Text(
                                            tr("skip"),
                                            style: TextStyles
                                                .textViewMedium15Underline
                                                .copyWith(color: black1),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  GenericButton(
                                    onPressed: () {
                                      pageContraller.nextPage(
                                          duration: Duration(milliseconds: 750),
                                          curve: Curves.fastLinearToSlowEaseIn);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          tr("next"),
                                          style: TextStyles.textViewSemiBold16
                                              .copyWith(color: white),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_outlined,
                                          color: white,
                                        ),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(15.sp),
                                    color: primary,
                                    width: 160.w,
                                  ),
                                ],
                              ),
                            ),
                    ],
                  ),
                ),
              );
            } else {
              return ErrorScreen();
            }
          },
        ),
      ),
    );
  }

  Widget buildBoarding(OnboardEntity model) => Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //  Expanded(child: Image.asset('${model.image}')),
            SizedBox(
              height: 20,
            ),
            Text(
              '${model.title}',
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(
              height: 10,
            ),
            Text('${model.description}'),
          ],
        ),
      );
}
