import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makanvi_web/core/custom_network.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/icons.dart';
import '../../../../../core/constant/images.dart';
import '../../../../../core/constant/styles/styles.dart';
import '../../../../../core/util/end_points.dart';
import '../../../../../core/util/navigator.dart';
import '../../../../../injection_container.dart';
import '../../../../favourite/presentation/widgets/favourite_icon.dart';
import '../../../../seller_pages/listining_seller/data/models/my_listing_model.dart';
import '../../../../seller_pages/listining_seller/presentation/pages/property_details.dart';

class PropertyCard extends StatelessWidget {
  final bool fromMap;
  final Property property;

  const PropertyCard({super.key, required this.property, this.fromMap = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          fromMap ? EdgeInsets.symmetric(vertical: 10) : EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          sl<AppNavigator>()
              .push(screen: PropertyDetails(listingId: property.id.toString()));
        },
        child: Container(
          height: 105.h,
          width: 280.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r), color: white),
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  height: 120.h,
                  width: 120.w,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.5.r),
                        child: property.coverImage.isEmpty
                            ? Image.asset(homeImage)
                            : CustomImageWidgegt(
                                image:
                                    EndPoints.baseImages + property.coverImage,
                                width: 200.w,
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: FavoriteIcon(
                              id: property.id,
                              isFavorite: property.isFav,
                            )),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "${property.title}",
                        style: TextStyles.textViewMedium12
                            .copyWith(color: Color(0xff252B5C)),
                      ),
                      // SizedBox(
                      //   height: 10.h,
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(locationIconsSvg),
                          Expanded(
                            child: Text(
                              "${property.location.country},${property.location.state},${property.location.city}",
                              // overflow: TextOverflow.ellipsis,
                              style: TextStyles.textViewMedium10
                                  .copyWith(color: textColorLight),
                            ),
                          )
                        ],
                      ),
                      Text(
                        "${property.currency} ${property.price.toString()}",
                        style: TextStyles.textViewSemiBold15
                            .copyWith(color: Color(0xff252B5C)),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
