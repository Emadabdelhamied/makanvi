import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/styles/styles.dart';

class EmptyChatWidget extends StatelessWidget {
  const EmptyChatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Image.asset(messageIconSvg),
        const SizedBox(
          height: 10,
        ),
        Center(
          child: Text(
            tr("no_message"),
            style: TextStyles.textViewMedium16.copyWith(color: textColor),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Center(
          child: Text(
            tr("Connect with others on Makanvi by starting a new conversation"),
            textAlign: TextAlign.center,
            style: TextStyles.textViewLight15.copyWith(color: textColor),
          ),
        ),
      ],
    );
  }
}
