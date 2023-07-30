import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:makanvi_web/core/constant/styles/styles.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../../../core/constant/colors/colors.dart';

class SliderRangeWidget extends StatelessWidget {
  final Function(SfRangeValues) onChanged;
  final SfRangeValues values;
  final String text;

  final double min;
  final double max;
  final double interval;
  final bool area;
  const SliderRangeWidget({
    super.key,
    required this.onChanged,
    required this.values,
    required this.text,
    required this.min,
    required this.max,
    required this.interval,
    required this.area,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyles.textViewSemiBold16.copyWith(color: black1),
            ),
            Text(
              area
                  ? "${values.start.toStringAsFixed(0)} ${tr("sq_range")} - ${(values.end).toStringAsFixed(0)} ${tr("sq_range")}"
                  : "${tr("phd")} ${NumberFormat("#,##0", "en_US").format(values.start)} - ${tr("phd")} ${NumberFormat("#,##0", "en_US").format(values.end)}",
              style: TextStyles.textViewBold12.copyWith(color: titelsColor),
            )
          ],
        ),
        SfRangeSlider(
          min: min,
          max: max,
          values: values,
          interval: interval,
          showDividers: true,
          inactiveColor: white,
          activeColor: iconColor,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
