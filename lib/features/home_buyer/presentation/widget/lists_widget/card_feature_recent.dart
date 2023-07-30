import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/icons.dart';
import '../../../../../core/constant/images.dart';
import '../../../../../core/constant/styles/styles.dart';
import '../../../../../core/custom_network.dart';
import '../../../../../core/util/end_points.dart';
import '../../../../../core/util/navigator.dart';
import '../../../../../injection_container.dart';
import '../../../../favourite/presentation/widgets/favourite_icon.dart';
import '../../../../seller_pages/listining_seller/presentation/pages/property_details.dart';
import '../../../data/models/home_buer_model.dart';

class CardFeatureAndRecent extends StatelessWidget {
  const CardFeatureAndRecent({super.key, required this.item});
  final Featured item;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: InkWell(
        onTap: () {
          sl<AppNavigator>()
              .push(screen: PropertyDetails(listingId: item.id.toString()));
        },
        child: Row(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.5.r),
                  child: Container(
                    height: 130.h,
                    width: 140.w,
                    child: item.coverImage.isEmpty
                        ? Image.asset(homeImage)
                        : CustomImageWidgegt(
                            image: EndPoints.baseImages + item.coverImage,
                            width: 200.w,
                          ),
                  ),
                ),
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(5.r),
                //   child: Container(
                //     height: 130.h,
                //     width: 140.w,
                //     decoration: item.coverImage.isNotEmpty
                //         ? BoxDecoration(
                //             //borderRadius: BorderRadius.circular(25.r),
                //             image: DecorationImage(
                //                 image: NetworkImage(
                //                     EndPoints.baseImages + item.coverImage)))
                //         : BoxDecoration(
                //             image: DecorationImage(
                //                 image: AssetImage(prpoertyPlaceholderImage))),
                //   ),
                // ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FavoriteIcon(
                        isFavorite: item.isFav ?? false,
                        id: item.id,
                      )),
                )
              ],
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
                    item.title,
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
                          "${item.location.country},${item.location.state},${item.location.city}",
                          // overflow: TextOverflow.ellipsis,
                          style: TextStyles.textViewMedium10
                              .copyWith(color: textColorLight),
                        ),
                      )
                    ],
                  ),
                  Text(
                    "${item.currency} ${item.price}",
                    style: TextStyles.textViewSemiBold15
                        .copyWith(color: Color(0xff252B5C)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
