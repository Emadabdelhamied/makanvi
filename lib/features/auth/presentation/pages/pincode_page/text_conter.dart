import 'package:flutter/material.dart';

import '../../../../../core/constant/styles/styles.dart';

Widget buildDurationTime(duration) {
  int minutes = (duration ~/ 60) % 60;
  int seconds = duration % 60;
  // String twoDigits(int number) => number.toString().padLeft(2, '0');
  // final minutes = duration.inMinutes.remainder(60);
  // final seconds = twoDigits(duration.inSeconds.remainder(60));
  return Text(
    '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
    style: TextStyles.textViewMedium16,
  );
}
