import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/icons.dart';
import '../../../../../core/constant/styles/styles.dart';
import '../../../../../core/widgets/loading.dart';
import '../../../../../injection_container.dart';
import '../../data/models/get_package_model.dart';
import '../../domain/usecase/get_package_usecase.dart';
import '../cubit/card_payment/card_payment_cubit.dart';
import '../cubit/get_package_payment_cubit/get_package_payment_cubit.dart';
import '../cubit/payment_intent/payment_intent_cubit.dart';

class CardListPaymentWidget extends StatefulWidget {
  const CardListPaymentWidget({super.key, required this.cards});
  final List<CardPayment> cards;

  @override
  State<CardListPaymentWidget> createState() => _CardListPaymentWidgetState();
}

class _CardListPaymentWidgetState extends State<CardListPaymentWidget> {
  int? select;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        // physics: NeverScrollableScrollPhysics(),
        itemCount: widget.cards.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          var item = widget.cards[index];
          return Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: select == index ? primary : transparentColor),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Container(
              height: 75.h,
              width: MediaQuery.of(context).size.width,
              child: ListTile(
                onTap: () {
                  setState(() {
                    select = index;
                  });
                  context.read<PaymentIntentCubit>().cardId = item.id;
                  log(context.read<PaymentIntentCubit>().cardId.toString());
                },
                leading: Container(
                  height: 48.h,
                  width: 48.w,
                  alignment: Alignment.center,
                  // decoration: BoxDecoration(
                  //     color: cardBackground, shape: BoxShape.circle),
                  child: Container(
                    height: 25.h,
                    width: 25.w,
                    child: SvgPicture.asset(
                      masterSvg,
                    ),
                  ),
                ),
                title: Text(
                  "xxxxx-${item.last4}",
                  style: TextStyles.textViewMedium15.copyWith(color: textColor),
                ),
                subtitle: Text(
                  "${tr("expiresـin")} ${item.expiryMonth}/${item.expiryYear}",
                  style: TextStyles.textViewMedium11.copyWith(color: textColor),
                ),
                trailing: BlocProvider(
                  create: (context) => sl<CardPaymentCubit>(),
                  child: BlocConsumer<CardPaymentCubit, CardPaymentState>(
                    listener: (context, state) {
                      if (state is SucessDeleteCardIntent) {
                        context
                            .read<GetPackagePaymentCubit>()
                            .fGetPaymentPackage(GetPackageParms(
                                target: "agency", purpose: "listing"));
                      }
                      // TODO: implement listener
                    },
                    builder: (context, state) {
                      if (state is DeleteCardIntentLoading) {
                        return Container(
                          height: 20,
                          width: 20,
                          child: Center(
                            child: Loading(),
                          ),
                        );
                      }
                      return InkWell(
                        onTap: () {
                          context
                              .read<CardPaymentCubit>()
                              .fDeleteCardPayment(id: item.id);
                        },
                        child: SvgPicture.asset(
                          DeleteSvg,
                          color: primary,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        });
  }
}
