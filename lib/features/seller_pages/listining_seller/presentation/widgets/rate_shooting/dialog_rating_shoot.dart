import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/constant/colors/colors.dart';
import '../../../../../../core/constant/styles/styles.dart';
import '../../../../../../core/util/navigator.dart';
import '../../../../../../core/widgets/button.dart';
import '../../../../../../core/widgets/loading.dart';
import '../../../../../../core/widgets/rate_star.dart';
import '../../../../../../core/widgets/toast.dart';
import '../../../../../../injection_container.dart';
import '../../../../home_seller/presentation/cubit/home_cubit.dart';
import '../../../../home_seller/presentation/pages/home_main_seller.dart';
import '../../../domain/usecases/rate_shotting_usecase.dart';
import '../../cubit/rate_shotting_cubit/rate_shotting_cubit.dart';
import 'text_field_rate.dart';

class DialogRateShotting extends StatefulWidget {
  final int propertyId;
  DialogRateShotting({
    super.key,
    required this.propertyId,
  });

  @override
  State<DialogRateShotting> createState() => _DialogRateShottingState();
}

class _DialogRateShottingState extends State<DialogRateShotting> {
  int rate = 0;
  TextEditingController message = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: BlocProvider(
        create: (BuildContext context) => sl<RateShottingCubit>(),
        child: SizedBox(
          height: 500.h,
          width: double.maxFinite,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  // height: 97.h,
                  // width: 97.w,
                  // decoration: BoxDecoration(
                  //   color: Color(0xff11CF74).withOpacity(0.15),
                  //   shape: BoxShape.circle,
                  //   // borderRadius: BorderRadius.circular(4.r),
                  //   // image: DecorationImage(image: AssetImage(searchFieldIcon)),
                  // ),
                  backgroundColor: Color(0xffFDB54A).withOpacity(0.15),
                  radius: 50.r,
                  child: CircleAvatar(
                      radius: 30.r,
                      backgroundColor: Color(0xffFDB54A),
                      child: Icon(
                        Icons.star_border,
                        color: white,
                      )),
                ),
                Text(
                  tr("how_was_your_experience_with_our_shooting_team"),
                  style: TextStyles.textViewMedium15.copyWith(color: textColor),
                  textAlign: TextAlign.center,
                ),
                Text(
                  tr("rate_your_experience"),
                  style: TextStyles.textViewBold15.copyWith(color: textColor),
                  textAlign: TextAlign.center,
                ),
                // SizedBox(
                //   height: 20.h,
                // ),
                Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: SizedBox(
                        width: 200.w,
                        height: 50.h,
                        child: StarRating(
                          onRatingChanged: (value) {
                            setState(() {});
                            rate = value;
                          },
                          rating: rate,
                        ))),

                TextFieldRate(
                  hintText: tr("typing"),
                  maxLines: 3,
                  controller: message,
                ),
                // ListViewDate(),
                BlocConsumer<RateShottingCubit, RateShottingState>(
                  listener: (context, state) async {
                    if (state is RateShotingSucess) {
                      customToast(
                          backgroundColor: green,
                          textColor: white,
                          content: state.message);
                      context
                          .read<HomeSellerCubit>()
                          .setcurrentIndexSellerHome = 1;

                      await sl<AppNavigator>()
                          .pushToFirst(screen: HomeMainSeller());
                    }
                    if (state is RateShotingError) {
                      customToast(
                          backgroundColor: red,
                          textColor: white,
                          content: state.message);
                    }
                  },
                  builder: (context, state) {
                    if (state is RateShotingLoading) {
                      return Center(
                        child: Loading(),
                      );
                    }
                    return GenericButton(
                        width: 220.w,
                        onPressed: () {
                          if (rate == 0) {
                            customToast(
                                backgroundColor: red,
                                textColor: white,
                                content: "Select Rate");
                          } else if (message.text.isEmpty) {
                            customToast(
                                backgroundColor: red,
                                textColor: white,
                                content: "Enter Review");
                          } else {
                            context.read<RateShottingCubit>().fRateShoting(
                                ratingShootParams: RatingShootParams(
                                    propertyId: widget.propertyId,
                                    rate: rate,
                                    review: message.text));
                          }
                        },
                        color: primary,
                        height: 45.h,
                        borderRadius: BorderRadius.circular(10),
                        child: Text(
                          tr("submit"),
                          style: TextStyles.textViewSemiBold16
                              .copyWith(color: white),
                        ));
                  },
                ),
              ]),
        ),
      ),
    );
  }
}
