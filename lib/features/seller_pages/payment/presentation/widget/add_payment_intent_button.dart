import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:moneyhash_payment/moneyhash_payment.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/styles/styles.dart';
import '../../../../../core/util/navigator.dart';
import '../../../../../core/widgets/button.dart';
import '../../../../../core/widgets/loading.dart';
import '../../../../../core/widgets/toast.dart';
import '../../../../../injection_container.dart';
import '../../../home_seller/presentation/cubit/home_cubit.dart';
import '../../../home_seller/presentation/pages/home_main_seller.dart';
import '../../domain/usecase/add_payment_intent_usecase.dart';
import '../cubit/payment_intent/payment_intent_cubit.dart';
import 'dialog_select_shoting.dart';

class AddPaymentButton extends StatefulWidget {
  const AddPaymentButton(
      {super.key, this.packageId, this.listingId, this.stutas});
  final String? packageId;
  final String? listingId;
  final String? stutas;

  @override
  State<AddPaymentButton> createState() => _AddPaymentButtonState();
}

class _AddPaymentButtonState extends State<AddPaymentButton> {
  // MoneyHashPaymentResult? _result;

  String? errorText;
  // Future<void> initPlatformState(String intent) async {
  //   MoneyHashPaymentResult? result;
  //   try {
  //     result = await MoneyhashPayment.startPaymentFlow(intent);
  //   } on PlatformException {
  //     // Handle the errors
  //   }

  //   // If the widget was removed from the tree while the asynchronous platform
  //   // message was in flight, we want to discard the reply rather than calling
  //   // setState to update our non-existent appearance.
  //   if (!mounted) return;

  //   setState(() async {
  //     _result = result;
  //     if (result!.status == "success") {
  //       customToast(
  //           backgroundColor: Colors.green,
  //           textColor: white,
  //           content: "success processing the payment.");
  //       if (widget.stutas == "feature" || widget.stutas == '') {
  //         context.read<HomeSellerCubit>().setcurrentIndexSellerHome = 1;
  //         await sl<AppNavigator>().pushToFirst(screen: HomeMainSeller());
  //       } else {
  //         await showDialog(
  //             barrierDismissible: false,
  //             context: context,
  //             builder: (_) {
  //               return AlertDialog(
  //                 shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.all(Radius.circular(15.0.r))),
  //                 content: DialogSelectShotting(
  //                   listingId: widget.listingId!,
  //                 ),
  //               );
  //             });
  //       }
  //     } else if (result.status == "failed") {
  //       customToast(
  //           backgroundColor: primary,
  //           textColor: white,
  //           content: "There was an error while processing the payment.");
  //       // AppNavigator.popToFrist(context: context);
  //       // context.read<MyListingsCubit>().fGetMyListingList(first: true);
  //     } else if (result.status == "cancelled") {
  //       customToast(
  //           backgroundColor: primary, textColor: white, content: "Cancelled");
  //       // AppNavigator.popToFrist(context: context);
  //       // context.read<MyListingsCubit>().fGetMyListingList(first: true);
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentIntentCubit, PaymentIntentState>(
      listener: (context, state) {
        if (state is SucessAddPaymentIntent) {
          // initPlatformState(state.intentId);
        }
      },
      builder: (context, state) {
        if (state is AddPaymentIntentLoading) {
          return const Center(
            child: Loading(),
          );
        }
        return GenericButton(
          onPressed: () {
            log(context.read<PaymentIntentCubit>().cardId.toString());
            var cardId = context.read<PaymentIntentCubit>().cardId.toString();
            context.read<PaymentIntentCubit>().fAddCardPayment(
                addIntentPaymentParms: AddIntentPaymentParms(
                    listingId: widget.listingId,
                    packageId: widget.packageId.toString(),
                    cardId: cardId));
            // sl<AppNavigator>()
            //     .push(screen: DialogSucessPaymentPage());
          },
          color: primary,
          width: MediaQuery.of(context).size.width,
          borderRadius: BorderRadius.circular(15.r),
          child: Text(
            tr("pay"),
            style: TextStyles.textViewMedium15.copyWith(color: white),
          ),
        );
      },
    );
  }
}
