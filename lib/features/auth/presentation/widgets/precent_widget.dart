import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../core/constant/colors/colors.dart';

class PrecentWidget extends StatelessWidget {
  const PrecentWidget({super.key, required this.percent});
  final double percent;
  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      // width: MediaQuery.of(context).size.width.w,
      padding: EdgeInsets.zero,
      lineHeight: 6.h,
      animation: false,
      animationDuration: 1000,
      percent: percent,
      barRadius: Radius.circular(15.r),
      progressColor: primary,
    );
  }
}
