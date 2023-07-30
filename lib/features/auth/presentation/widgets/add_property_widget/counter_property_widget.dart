import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/styles/styles.dart';

class CounterWidget extends StatelessWidget {
  const CounterWidget({super.key, required this.title, required this.count});
  final String title;
  final String count;
  @override
  Widget build(BuildContext context) {
    var currentLocal = Localizations.localeOf(context).languageCode;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyles.textViewMedium14.copyWith(color: black),
        ),
        Container(
          height: 35.h,
          width: 91.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(23.r), color: iconColor),
          child: Center(
            child: Text(
              currentLocal == "ar" ? "٤ / $count" : '0$count/04',
              style: TextStyles.textViewMedium16.copyWith(color: white),
            ),
          ),
        )
      ],
    );
  }
}
