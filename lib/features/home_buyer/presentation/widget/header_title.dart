import 'package:flutter/material.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/styles/styles.dart';

class HeaderTitle extends StatelessWidget {
  const HeaderTitle(
      {super.key,
      required this.title,
      required this.titleAll,
      required this.onTap});
  final String title;
  final String titleAll;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyles.textViewSemiBold16.copyWith(color: textColor),
        ),
        Spacer(),
        InkWell(
          onTap: onTap,
          child: Text(
            titleAll,
            style: TextStyles.textViewBold14UndeLine.copyWith(color: primary),
          ),
        ),
      ],
    );
  }
}
