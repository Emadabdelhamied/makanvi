import 'package:easy_localization/easy_localization.dart';
import 'package:flag/flag_enum.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/styles/styles.dart';
import '../../data/models/countery_model.dart';

class CountryWidget extends StatelessWidget {
  final Color borderColor;
  final Color backGroundColor;
  final String text;
  final String countryCode;
  final int isActive;
  final Function() onTap;
  final CountryAuth? countryAuth;
  const CountryWidget({
    super.key,
    required this.borderColor,
    required this.text,
    required this.isActive,
    required this.onTap,
    required this.countryCode,
    required this.backGroundColor,
    this.countryAuth,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 72.h,
        width: 336.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: backGroundColor,
          border: Border.all(
            color: borderColor,
          ),
        ),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        backgroundColor:
                            isActive == 0 ? transparentColor : white,
                        // backgroundImage: NetworkImage(countryCode),
                        // child: Image.network(countryCode)
                        child: Flag.fromString(
                          countryCode,
                          height: 50,
                          width: 50,
                          fit: BoxFit.fill,
                          flagSize: FlagSize.size_1x1,
                          borderRadius: 25,
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: isActive == 1
                            ? Colors.transparent
                            : Color(0xff61646B).withOpacity(0.7),
                        child: Container(
                          height: 50,
                          width: 50,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    text,
                    style: TextStyles.textViewMedium16.copyWith(
                        color: isActive == 0 ? Color(0xff61646B) : textColor),
                  ),
                ]),
                isActive == 0
                    ? Text(
                        tr("soon"),
                        style: TextStyles.textViewMedium15
                            .copyWith(color: Color(0xff61646B)),
                      )
                    : SizedBox()
              ],
            )),
      ),
    );
  }
}
