import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/icons.dart';
import '../../../../core/constant/images.dart';
import '../../../../core/constant/styles/styles.dart';
import '../../../../core/util/end_points.dart';
import '../../../../core/util/navigator.dart';
import '../../../../injection_container.dart';
import '../../../seller_pages/listining_seller/presentation/pages/property_details.dart';
import '../../data/models/get_all_messages_model.dart';

class CardPropertyMessage extends StatelessWidget {
  const CardPropertyMessage(
      {super.key, required this.propertyMessage, this.isMine});
  final PropertyMessage propertyMessage;
  final bool? isMine;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        sl<AppNavigator>().push(
            screen: PropertyDetails(
          listingId: propertyMessage.id.toString(),
        ));
      },
      child: Container(
        // height: 135.h,
        // decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(15.r), color: cardBackground),
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
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    image: propertyMessage.coverImage.isEmpty
                        ? DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(prpoertyPlaceholderImage))
                        : DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(EndPoints.baseImages +
                                propertyMessage.coverImage))),
                // child: Image.asset(
                //   image2,
                //   height: 120.h,
                //   fit: BoxFit.fill,
                // ),
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
                    // "Apartment for Sale in Al Juffair",
                    propertyMessage.title,
                    style: TextStyles.textViewMedium12.copyWith(
                        color: isMine == true ? white : Color(0xff252B5C)),
                  ),
                  // SizedBox(
                  //   height: 10.h,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        locationIconsSvg,
                        color: isMine == true ? white : textColor,
                      ),
                      Expanded(
                        child: Text(
                          // "Al Juffair, Capital Governorate",
                          "${propertyMessage.location.country},${propertyMessage.location.state},${propertyMessage.location.city}",
                          // overflow: TextOverflow.ellipsis,
                          style: TextStyles.textViewMedium10.copyWith(
                              color: isMine == true ? white : textColorLight),
                        ),
                      )
                    ],
                  ),
                  Text(
                    propertyMessage.price.toString(),
                    style: TextStyles.textViewSemiBold15.copyWith(
                        color: isMine == true ? white : Color(0xff252B5C)),
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
