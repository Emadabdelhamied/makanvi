import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/constant/colors/colors.dart';
import '../../../../../../core/constant/styles/styles.dart';
import '../../../../../../core/util/navigator.dart';
import '../../../../../../core/widgets/button.dart';
import '../../../../../../injection_container.dart';
import '../../../../home_seller/presentation/cubit/home_cubit.dart';
import '../../../../home_seller/presentation/pages/home_main_seller.dart';

class AgancyDialogSucessCnofirm extends StatelessWidget {
  const AgancyDialogSucessCnofirm({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 400.h,
        width: double.maxFinite,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                // height: 97.h,
                // width: 97.w,
                // decoration: BoxDecoration(
                //   color: Color(0xff11CF74).withOpacity(0.15),
                //   shape: BoxShape.circle,
                //   // borderRadius: BorderRadius.circular(4.r),
                //   // image: DecorationImage(image: AssetImage(searchFieldIcon)),
                // ),
                backgroundColor: Color(0xff634AFD).withOpacity(0.15),
                radius: 50.r,
                child: CircleAvatar(
                  radius: 30.r,
                  backgroundColor: Color(0xff634AFD),
                  child: Text(
                    "✓",
                    style: TextStyles.textViewRegular25.copyWith(color: white),
                  ),
                ),
              ),
              Text(
                tr("package_request_confirmed"),
                style: TextStyles.textViewBold15.copyWith(color: textColor),
                textAlign: TextAlign.center,
              ),
              // SizedBox(
              //   height: 20.h,
              // ),
              Text(
                tr("your_package_request_was_successful_our_account_manager"),
                style: TextStyles.textViewMedium13.copyWith(color: textColor),
                textAlign: TextAlign.center,
              ),
              GenericButton(
                  width: 220.w,
                  onPressed: () {
                    context.read<HomeSellerCubit>().setcurrentIndexSellerHome =
                        1;
                    sl<AppNavigator>().push(screen: HomeMainSeller());
                  },
                  color: primary,
                  height: 45.h,
                  borderRadius: BorderRadius.circular(10),
                  child: Text(
                    tr("done"),
                    style: TextStyles.textViewSemiBold16.copyWith(color: white),
                  )),
            ]));
  }
}
