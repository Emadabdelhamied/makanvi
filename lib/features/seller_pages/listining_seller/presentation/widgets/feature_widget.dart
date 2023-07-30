import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/icons.dart';
import '../../../../../core/custom_network.dart';
import '../../../../../core/util/end_points.dart';
import '../../data/models/my_listing_model.dart';

class FeatureWidget extends StatelessWidget {
  final List<Features> features;
  FeatureWidget({super.key, required this.features});
  final List featuresIcon = [
    bedRoomSvg,
    bathRoomSvg,
    livingRoomSvg,
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemCount: features.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Container(
              height: 45.h,
              width: 150.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.r),
                  color: cardBackground),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  children: [
                    features[index].path.isEmpty
                        ? SizedBox()
                        : CustomImageWidgegt(
                            image: EndPoints.baseImages + features[index].path,
                            width: 25.w,
                            height: 25.h,
                          ),
                    //SvgPicture.asset(featuresIcon[index]),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text("${features[index].count} ${features[index].title}")
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
