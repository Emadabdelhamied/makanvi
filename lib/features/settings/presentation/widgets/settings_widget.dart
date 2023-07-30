import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/icons.dart';
import '../../../../core/constant/styles/styles.dart';

class SettingsWidget extends StatelessWidget {
  final String icon;
  final String text;
  final String subText;
  final Function() onTap;
  const SettingsWidget(
      {super.key,
      required this.icon,
      required this.text,
      required this.onTap,
      required this.subText});

  @override
  Widget build(BuildContext context) {
    var currentLocal = Localizations.localeOf(context).languageCode;

    return ListTile(
      onTap: onTap,
      leading: Container(
        height: 48.h,
        width: 48.w,
        alignment: Alignment.center,
        decoration:
            BoxDecoration(color: cardBackground, shape: BoxShape.circle),
        child: Container(
          height: 25.h,
          width: 25.w,
          child: SvgPicture.asset(
            icon,
            color: titelsColor,
          ),
        ),
      ),
      title: Text(
        text,
        style: TextStyles.textViewMedium15.copyWith(color: textColor),
      ),
      subtitle: subText.isEmpty
          ? null
          : Text(
              subText,
              style: TextStyles.textViewMedium11.copyWith(color: textColor),
            ),
      trailing: SvgPicture.asset(
          currentLocal == "ar" ? leftArrowIcon : rightArrowIcon),
    );
  }
}
