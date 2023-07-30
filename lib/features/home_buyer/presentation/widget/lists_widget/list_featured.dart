import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../data/models/home_buer_model.dart';
import 'card_feature_recent.dart';

class ListFeatured extends StatelessWidget {
  const ListFeatured({super.key, required this.featured});
  final List<Featured> featured;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 145.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: featured.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h),
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(15.r),
              child: Container(
                height: 135.h,
                width: 268.w,
                decoration: BoxDecoration(
                  color: cardBackground,
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: InkWell(
                  onTap: () {
                    // sl<AppNavigator>().push(
                    //     screen: PropertyDetails(
                    //   listingId: featured[index].id.toString(),
                    // ));
                  },
                  child: CardFeatureAndRecent(
                    item: featured[index],
                  ),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) =>
            SizedBox(width: 10.w),
      ),
    );
  }
}
