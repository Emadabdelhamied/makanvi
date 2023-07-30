import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:makanvi_web/core/constant/colors/colors.dart';

import '../../../../../core/constant/styles/styles.dart';

class EmptyListingScreen extends StatelessWidget {
  final String text;
  final String image;
  final String subText;

  const EmptyListingScreen(
      {super.key,
      required this.text,
      required this.image,
      required this.subText});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 40.h,
          ),
          Image.asset(
            image,
            width: 220.w,
            height: 220.h,
          ),
          Text(
            text,
            style: TextStyles.textViewMedium18.copyWith(color: textColor),
          ),
          SizedBox(
            height: 16.h,
          ),
          Text(
            subText,
            style: TextStyles.textViewMedium14.copyWith(color: textColor),
          ),
        ],
      ),
    );
  }
}
