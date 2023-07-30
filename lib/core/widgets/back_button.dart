import 'package:flutter/material.dart';

import '../constant/colors/colors.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key, this.color = primary});
  final Color color;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          alignment: AlignmentDirectional.centerStart,
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
          child: Stack(children: <Widget>[
            PositionedDirectional(
              bottom: 11,
              start: 11,
              child: Icon(Icons.arrow_back, color: Colors.grey[500]!),
            ),
            BackButton(color: color),
          ])),
    );
  }
}
