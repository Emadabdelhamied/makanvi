import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:makanvi_web/core/constant/colors/colors.dart';
import 'package:makanvi_web/core/constant/styles/styles.dart';
import 'package:makanvi_web/core/util/end_points.dart';

import '../../../../../core/custom_network.dart';
import '../../../../auth/data/models/get_data_add_probalty_model.dart';

class AmenitiesWidget extends StatelessWidget {
  final List<Amenity> amenities;
  const AmenitiesWidget({super.key, required this.amenities});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: amenities.length * 25.h,
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: amenities.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          // itemCount: amenities.length,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 6,
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          var item = amenities[index];
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomImageWidgegt(
                image: EndPoints.baseImages + item.iconPath!,
                width: 25.w,
                height: 25.h,
              ),
              SizedBox(
                width: 5.w,
              ),
              Text(
                item.title,
                style: TextStyles.textViewMedium12.copyWith(color: textColor),
              )
            ],
          );
        },
      ),
    );
  }
}
