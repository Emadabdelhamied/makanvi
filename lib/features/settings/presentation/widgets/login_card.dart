import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makanvi_web/core/constant/colors/colors.dart';
import 'package:makanvi_web/core/constant/images.dart';
import 'package:makanvi_web/core/constant/styles/styles.dart';

class LogInCard extends StatelessWidget {
  final Function() onTap;
  const LogInCard({super.key, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 30.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 22.h,
                    width: 22.w,
                    child: SvgPicture.asset(
                      person1,
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    'Sign In',
                    style: TextStyles.textViewRegular15.copyWith(color: red),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
