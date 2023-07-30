import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makanvi_web/features/seller_pages/payment/presentation/cubit/payment_info/payment_info_cubit.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/icons.dart';
import '../../../../../core/constant/styles/styles.dart';
import '../../../../../core/widgets/loading.dart';
import '../../../../../injection_container.dart';
import '../../../../seller_pages/payment/data/models/get_package_model.dart';
import '../../../../seller_pages/payment/presentation/cubit/card_payment/card_payment_cubit.dart';

class ListPaymentMethod extends StatefulWidget {
  final List<CardPayment> cards;
  const ListPaymentMethod({super.key, required this.cards});

  @override
  State<ListPaymentMethod> createState() => _ListPaymentMethodState();
}

class _ListPaymentMethodState extends State<ListPaymentMethod> {
  int select = 0;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
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
                        context.read<PaymentInfoCubit>().fGetPaymentInfo();
                      }
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
