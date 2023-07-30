import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/styles/styles.dart';
import '../../../../../core/widgets/button.dart';
import '../../../../../core/widgets/generic_field.dart';
import '../../../../settings/presentation/widgets/payment_widget/list_payment_method.dart';

class FeaturePage extends StatelessWidget {
  const FeaturePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: transparentColor,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Service Payment",
              style: TextStyles.textViewSemiBold16.copyWith(color: textColor),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "Your payment is 100% secure",
              style:
                  TextStyles.textViewMedium16.copyWith(color: textColorLight),
            ),
            SizedBox(
              height: 35.h,
            ),
            GenericField(
              labeltext: "Featuring",
              lableColor: textColor,
              isEnable: false,
              suffixIcon: Text(
                "53 BHD",
                style: TextStyles.textViewMedium18.copyWith(color: primary),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Text(
              "Card Details",
              style: TextStyles.textViewMedium16.copyWith(color: textColor),
            ),
            SizedBox(
              height: 10.h,
            ),
            ListPaymentMethod(
              cards: [],
            ),
            SizedBox(
              height: 20.h,
            ),
            InkWell(
              onTap: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.add,
                    color: focus,
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(
                    "Add New Card",
                    style: TextStyles.textViewMedium14.copyWith(color: focus),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 35.h,
            ),
            GenericButton(
              onPressed: () {
                // sl<AppNavigator>()
                //     .push(screen: DialogSucessPaymentPage());
              },
              child: Text(
                "Pay",
                style: TextStyles.textViewMedium15.copyWith(color: white),
              ),
              color: primary,
              width: MediaQuery.of(context).size.width,
              borderRadius: BorderRadius.circular(15.r),
            ),
          ],
        ),
      ),
    );
  }
}
