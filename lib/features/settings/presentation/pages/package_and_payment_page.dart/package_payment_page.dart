import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:makanvi_web/features/seller_pages/payment/presentation/cubit/payment_info/payment_info_cubit.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/styles/styles.dart';
import '../../../../../core/util/navigator.dart';
import '../../../../../core/widgets/appbar_generic.dart';
import '../../../../../core/widgets/error_screen.dart';
import '../../../../../core/widgets/loading.dart';
import '../../../../../injection_container.dart';
import '../../../../seller_pages/payment/presentation/widget/add_new_card_btton.dart';
import '../../widgets/payment_widget/current_package_card.dart';
import '../../widgets/payment_widget/list_payment_method.dart';
import '../settings.dart';

class PackageAndPaymentPage extends StatelessWidget {
  const PackageAndPaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        sl<AppNavigator>().push(screen: Settings());

        return true;
      },
      child: Scaffold(
          appBar: AppBarGeneric(
            title: tr("package_and_payment"),
            titleColor: textColor,
            onPressed: () {
              sl<AppNavigator>().push(screen: Settings());
            },
          ),
          body: BlocProvider(
              create: (context) => sl<PaymentInfoCubit>()..fGetPaymentInfo(),
              child: BlocConsumer<PaymentInfoCubit, PaymentInfoState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is PaymentInfoLoadingState) {
                    return Loading();
                  } else if (state is PaymentInfoSuccessState) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tr("current_package"),
                            style: TextStyles.textViewSemiBold16
                                .copyWith(color: textColor),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          CuurentPackageCard(
                              packages: state.data.subscriptions),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            tr("payment_method"),
                            style: TextStyles.textViewSemiBold16
                                .copyWith(color: textColor),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          ListPaymentMethod(cards: state.data.cards),
                          SizedBox(
                            height: 20.h,
                          ),
                          AddNewCardButton(
                            isPackagePage: true,
                          ),
                        ],
                      ),
                    );
                  } else {
                    return ErrorScreen();
                  }
                },
              ))),
    );
  }
}
