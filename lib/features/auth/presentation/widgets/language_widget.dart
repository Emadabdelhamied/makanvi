import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/styles/styles.dart';

class LanguageWidget extends StatelessWidget {
  final Color borderColor;
  final Color backGroundColor;
  final String text;
  final Function() onTap;
  const LanguageWidget({
    super.key,
    required this.borderColor,
    required this.text,
    required this.onTap,
    required this.backGroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 72.h,
        width: 336.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: backGroundColor,
          border: Border.all(
            color: borderColor,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Align(
            alignment: text == 'العربية'
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Text(
              text,
              style: TextStyles.textViewMedium18.copyWith(
                  color: textColor,
                  fontFamily: text == "العربية" ? "Almarai" : "Montserrat"),
            ),
          ),
        ),
      ),
    );
  }
}
