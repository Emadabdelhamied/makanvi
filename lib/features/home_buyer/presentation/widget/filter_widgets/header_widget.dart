import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/styles/styles.dart';

class HeaderWidget extends StatelessWidget {
  final Function() closeTap;
  final Function() resetTap;
  const HeaderWidget(
      {super.key, required this.closeTap, required this.resetTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(onPressed: closeTap, icon: Icon(Icons.close)),
        Text(
          tr("filters"),
          style: TextStyles.textViewBold16.copyWith(color: titelsColor),
        ),
        TextButton(
            onPressed: resetTap,
            child: Text(
              tr("reset"),
              style: TextStyles.textViewBold14UndeLine
                  .copyWith(color: titelsColor),
            ))
      ],
    );
  }
}
