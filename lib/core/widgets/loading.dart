import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
            width: 150.w,
            child: Lottie.asset(
              'assets/images/loading.json',
            )));
  }
}
