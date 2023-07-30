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
import '../../../data/models/feature_all_model.dart';

class CardFeatureAll extends StatelessWidget {
  const CardFeatureAll({super.key, required this.item});
  final FeatureAllData item;
  @override
  Widget build(BuildContext context) {
    var currentLocal = Localizations.localeOf(context).languageCode;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.w),
      child: InkWell(
        onTap: () {
          sl<AppNavigator>()
              .push(screen: PropertyDetails(listingId: item.id.toString()));
        },
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(15.r),
          child: Container(
            height: 135.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                color: cardBackground),
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            // alignment: Alignment.center,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    height: 120.h,
                    width: 140.w,
                    // decoration: BoxDecoration(
                    //     color: white, borderRadius: BorderRadius.circular(15)),
                    // alignment: Alignment.center,
                    child: Stack(
                      children: [
                        item.coverImage.isNotEmpty
                            ? CustomImageWidgegt(
                                image: EndPoints.baseImages + item.coverImage,
                                height: 120.h,
                              )
                            : Image.asset(
                                prpoertyPlaceholderImage,
                                height: 120.h,
                                width: double.maxFinite,
                                fit: BoxFit.fill,
                              ),
                        Align(
                            alignment: currentLocal == "ar"
                                ? Alignment.topRight
                                : Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FavoriteIcon(
                                id: item.id,
                                isFavorite: item.isFav ?? false,
                              ),
                            ))
                      ],
                    ),
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
        ),
      ),
    );
  }
}
