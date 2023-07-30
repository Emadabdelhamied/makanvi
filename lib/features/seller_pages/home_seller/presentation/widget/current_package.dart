import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/styles/styles.dart';
import '../../data/models/home_seller_model.dart';

class CurrentPackageWidget extends StatelessWidget {
  const CurrentPackageWidget({super.key, required this.subscriptions});
  final SubscriptionsHomeSeller subscriptions;
  @override
  Widget build(BuildContext context) {
    var count = subscriptions.listing == null
        ? ""
        : subscriptions.listing!.listingCount;
    var consume =
        subscriptions.listing == null ? "" : subscriptions.listing!.consume;
    return Container(
        height: 116.h,
        // alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            gradient: LinearGradient(colors: [
              background2Color,
              Color(0xffF8F8FA),
            ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "${tr("current_package")} ${subscriptions.listing == null ? "" : subscriptions.listing!.name}",
              style: TextStyles.textViewSemiBold18.copyWith(color: textColor),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.play_arrow,
                  size: 18,
                ),
                Text(
                  "${consume}/${count} ${tr("property_remaninig")}",
                  style: TextStyles.textViewMedium12.copyWith(color: textColor),
                ),
              ],
            ),
            Spacer(),
            Text(
              subscriptions.listing == null
                  ? ""
                  : subscriptions.listing!.cancled == 1
                      ? tr("cancled")
                      : " ${tr("your_next_payment_is_due")} ${subscriptions.listing!.expireAt}",
              style:
                  TextStyles.textViewRegularItalic12.copyWith(color: textColor),
            ),
            SizedBox(
              height: 8.h,
            )
          ],
        ));
  }
}
