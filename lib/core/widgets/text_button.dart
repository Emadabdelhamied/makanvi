import 'package:flutter/material.dart';

import '../constant/styles/styles.dart';

class RawyTextButton extends StatelessWidget {
  const RawyTextButton(
      {super.key, required this.onPressed, required this.text});
  final void Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyles.textViewMedium15,
        ));
  }
}
