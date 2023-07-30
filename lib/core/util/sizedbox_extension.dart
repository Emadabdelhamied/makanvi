import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension SizedBoxPadding on num {
  SizedBox get sizHeight => SizedBox(
        height: toDouble().h,
      );
  SizedBox get sizeWidth => SizedBox(
        width: toDouble().w,
      );
}
