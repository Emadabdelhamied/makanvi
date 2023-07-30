import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../bloc/main_cubit/bloc_main_cubit.dart';
import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/icons.dart';
import '../../../../../core/constant/styles/styles.dart';
import '../../../../../core/util/navigator.dart';
import '../../../../../core/widgets/button.dart';
import '../../../../../injection_container.dart';
import '../../../../seller_pages/payment/presentation/pages/agancy/agancy_listinig_used_screen.dart';
import '../../../../seller_pages/payment/presentation/pages/agancy/agancy_plan_details_page.dart';
import '../../../../seller_pages/payment/presentation/pages/plan_payment_page.dart';
import '../../../../seller_pages/payment/presentation/pages/screen_select_shotting_dailog.dart';

class DialogPaymentSucsses extends StatelessWidget {
  const DialogPaymentSucsses(
      {super.key,
      required this.listingId,
      required this.goTo,
      required this.isAgentFirst});
  final String listingId;
  final String goTo;
  final bool isAgentFirst;

  @override
  Widget build(BuildContext context) {
    final typeUser =
        context.read<BlocMainCubit>().repository.loadAppData()!.typeUser;
    return
        // BlocProvider(
        //   create: (BuildContext context) => sl<DeleteAccountCubit>(),
        //   child:
        SizedBox(
      height: 500.h,
      width: double.maxFinite,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                height: 155.h,
                width: 155.w,
                child: Image.asset(paymentDialogImage)),
            Text(
              tr("congratulations_your_property_is_ready_shooting"),
              style: TextStyles.textViewBold15.copyWith(color: textColor),
              textAlign: TextAlign.center,
            ),
            // SizedBox(
            //   height: 20.h,
            // ),
            Text(
              tr("upon_payment_our_shootting_team"),
              style: TextStyles.textViewMedium15.copyWith(color: textColor),
              textAlign: TextAlign.center,
            ),
            GenericButton(
                width: 220.w,
                onPressed: () async {
                  if ((goTo == "" || goTo == "pay") && typeUser != "agency") {
                    sl<AppNavigator>().push(
                        screen:
                            PalnPaymentPage(listingId: int.parse(listingId)));
                  } else if (goTo == "direct_upgrade") {
                    sl<AppNavigator>().push(
                        screen: ScreenSelectShottingDateDialog(
                      listingId: listingId,
                    ));
                    // await showDialog(
                    //     barrierDismissible: false,
                    //     context: context,
                    //     builder: (_) {
                    //       return AlertDialog(
                    //         shape: RoundedRectangleBorder(
                    //             borderRadius:
                    //                 BorderRadius.all(Radius.circular(15.0.r))),
                    //         content: DialogSelectShotting(
                    //           listingId: listingId,
                    //         ),
                    //       );
                    //     });
                  } else if (typeUser == "agency" && isAgentFirst == true) {
                    sl<AppNavigator>().push(screen: AgancyPlanDetails());
                  } else if (typeUser == "agency" && goTo == "pay") {
                    sl<AppNavigator>().push(screen: AgancyListingUsedScreen());
                  }
                  // typeUser == "agency"
                  //     ? sl<AppNavigator>().push(screen: AgancyPlanDetails())
                  //     : sl<AppNavigator>().push(
                  //         screen: PalnPaymentPage(
                  //         listingId: int.parse(listingId),
                  //       ));
                },
                color: primary,
                height: 45.h,
                borderRadius: BorderRadius.circular(10),
                child: Text(
                  goTo == "direct_upgrade"
                      ? "Go To Shooting"
                      : tr("go_to_payment"),
                  style: TextStyles.textViewSemiBold16.copyWith(color: white),
                )),
          ]),

      // ),
    );
  }
}
