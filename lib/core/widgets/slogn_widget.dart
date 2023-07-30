import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../constant/styles/styles.dart';

class SlognWidget extends StatelessWidget {
  const SlognWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(tr("slogn"),
        textAlign: TextAlign.center, style: TextStyles.textViewMedium15);
  }
}
