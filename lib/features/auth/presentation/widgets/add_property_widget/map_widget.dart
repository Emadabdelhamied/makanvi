import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/styles/styles.dart';

class MapCard extends StatelessWidget {
  final bool isSelected;
  final String text;
  const MapCard({super.key, required this.isSelected, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.h,
      width: 327.w,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(
          15.r,
        ),
        // border: Border.all(color: iconColor),
      ),
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tr("Location details"),
            style: TextStyles.textViewMedium14.copyWith(color: textColor),
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.h,
                decoration:
                    BoxDecoration(color: secondry2, shape: BoxShape.circle),
                child: Icon(
                  Icons.location_on,
                  color: white,
                ),
              ),
              SizedBox(
                width: 8.w,
              ),
              Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: TextStyles.textViewMedium12.copyWith(
                  color: iconColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
