import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/styles/styles.dart';
import '../../../../../core/util/navigator.dart';
import '../../../../../injection_container.dart';
import '../cubit/card_payment/card_payment_cubit.dart';
import 'web_view_test.dart';

class AddNewCardButton extends StatefulWidget {
  const AddNewCardButton(
      {super.key,
      this.listingId,
      this.purpose,
      this.target,
      this.isPackagePage = false});
  final int? listingId;
  final String? purpose;
  final String? target;
  final bool isPackagePage;
  @override
  State<AddNewCardButton> createState() => _AddNewCardButtonState();
}

class _AddNewCardButtonState extends State<AddNewCardButton> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CardPaymentCubit>(),
      child: BlocConsumer<CardPaymentCubit, CardPaymentState>(
        listener: (context, state) {
          if (state is SucessAddCardIntent) {
            // initPlatformState(state.intentId);
            sl<AppNavigator>().push(
                screen: PaymentScreen(
              paymentUrl: state.intentId,
              target: widget.target,
              purpose: widget.purpose,
              listingId: widget.listingId,
              isPackagePage: widget.isPackagePage,
            ));
          }
        },
        builder: (context, state) {
          return InkWell(
            onTap: () {
              context.read<CardPaymentCubit>().fAddCardPayment();
            },
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
                  tr("add_new_card"),
                  style: TextStyles.textViewMedium14.copyWith(color: focus),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
