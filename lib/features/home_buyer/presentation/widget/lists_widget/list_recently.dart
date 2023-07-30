import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../data/models/home_buer_model.dart';
import 'card_feature_recent.dart';

class ListRecently extends StatelessWidget {
  const ListRecently({super.key, required this.recently});
  final List<Featured> recently;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300.h,
      child: ListView.builder(
          // scrollDirection: Axis.horizontal,
          physics: NeverScrollableScrollPhysics(),
          itemCount: recently.take(2).toList().length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 15.h),
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(15.r),
                child: Padding(
                  padding: EdgeInsets.only(right: 0.w),
                  child: Container(
                    height: 135.h,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: cardBackground,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: CardFeatureAndRecent(
                      item: recently[index],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
