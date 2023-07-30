import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/constant/colors/colors.dart';
import '../../../../../../core/constant/styles/styles.dart';
import '../../../../../../core/util/navigator.dart';
import '../../../../../../core/widgets/button.dart';
import '../../../../../../injection_container.dart';
import '../../../../../home_buyer/presentation/pages/home_main_buyer.dart';
import 'set_location_buyer_screen.dart';

class DialogShareLocation extends StatelessWidget {
  const DialogShareLocation({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300.h,
      width: double.maxFinite,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // SizedBox(
            //   height: 10.h,
            // ),
            Text(
              tr("location_access"),
              style: TextStyles.textViewMedium15.copyWith(color: textColor),
              textAlign: TextAlign.center,
            ),
            // SizedBox(
            //   height: 10.h,
            // ),
            Text(
              tr("share_your_location_to_get_best_experience"),
              style: TextStyles.textViewMedium15.copyWith(color: textColor),
              textAlign: TextAlign.center,
            ),
            GenericButton(
                width: 220.w,
                onPressed: () {
                  // context
                  //     .read<ClosePropertyCubit>()
                  //     .fCloseProperty(
                  //         listingId: listingId.toString());

                  // sl<AppNavigator>().push(screen: SetLocationBuyerScreen());
                },
                color: primary,
                // height: 45.h,
                borderRadius: BorderRadius.circular(10),
                child: Text(
                  tr("share_location"),
                  style: TextStyles.textViewSemiBold16.copyWith(color: white),
                )),

            Center(
              child: TextButton(
                  onPressed: () {
                    sl<AppNavigator>().pushToFirst(screen: HomeMainBuyer());
                  },
                  child: Text(
                    tr("no_thanks"),
                    style: TextStyles.textViewSemiBold16.copyWith(color: black),
                  )),
            )
          ]),

      // ),
    );
  }
}
