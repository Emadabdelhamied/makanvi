import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/styles/styles.dart';
import '../../../../../core/util/navigator.dart';
import '../../../../../core/widgets/button.dart';
import '../../../../../injection_container.dart';
import '../../../payment/presentation/pages/plan_payment_page.dart';

class DialogFeature extends StatelessWidget {
  const DialogFeature({super.key, required this.listingId});
  final int listingId;
  @override
  Widget build(BuildContext context) {
    return
        // BlocProvider(
        //   create: (BuildContext context) => sl<DeleteAccountCubit>(),
        //   child:
        SizedBox(
      height: 180.h,
      width: double.maxFinite,
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              sl<AppNavigator>().pop();
            },
            child: Align(
              alignment: Alignment.topRight,
              child: Icon(Icons.close),
            ),
          ),
          Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  tr("want_to_give_your_property_feature_more_attention"),
                  style: TextStyles.textViewMedium15.copyWith(color: textColor),
                  textAlign: TextAlign.center,
                ),
                GenericButton(
                    width: 220.w,
                    onPressed: () {
                      sl<AppNavigator>().push(
                          screen: PalnPaymentPage(
                        listingId: listingId,
                        purpose: "feature",
                        target: "owner",
                      ));
                    },
                    color: primary,
                    // height: 45.h,
                    borderRadius: BorderRadius.circular(10),
                    child: Text(
                      tr("feature_property"),
                      style:
                          TextStyles.textViewSemiBold16.copyWith(color: white),
                    )),
              ]),
        ],
      ),

      // ),
    );
  }
}
