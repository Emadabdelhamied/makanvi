import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../bloc/main_cubit/bloc_main_cubit.dart';
import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/styles/styles.dart';
import '../../../../../core/util/navigator.dart';
import '../../../../../core/widgets/error_screen.dart';
import '../../../../../core/widgets/generic_field.dart';
import '../../../../../core/widgets/loading.dart';
import '../../../../../injection_container.dart';
import '../../../home_seller/presentation/cubit/home_cubit.dart';
import '../../../home_seller/presentation/pages/home_main_seller.dart';
import '../../domain/usecase/get_package_usecase.dart';
import '../cubit/get_package_payment_cubit/get_package_payment_cubit.dart';
import '../cubit/payment_intent/payment_intent_cubit.dart';
import '../widget/add_new_card_btton.dart';
import '../widget/add_payment_intent_button.dart';
import '../widget/card_payment_widget.dart';

class PalnPaymentPage extends StatelessWidget {
  PalnPaymentPage(
      {super.key,
      required this.listingId,
      this.purpose = "listing",
      this.target = "owner"});
  final int? listingId;
  final String? purpose;
  final String? target;
  int? packageId;
  @override
  Widget build(BuildContext context) {
    final typeUser =
        context.read<BlocMainCubit>().repository.loadAppData()!.typeUser;
    return WillPopScope(
      onWillPop: () async {
        context.read<HomeSellerCubit>().setcurrentIndexSellerHome = 1;
        await sl<AppNavigator>().pushToFirst(screen: HomeMainSeller());
        return false;
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => sl<GetPackagePaymentCubit>()
                ..fGetPaymentPackage(
                    GetPackageParms(target: typeUser, purpose: purpose))),
          BlocProvider(create: (context) => sl<PaymentIntentCubit>())
        ],
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: transparentColor,
            automaticallyImplyLeading: false,
          ),
          body: BlocConsumer<GetPackagePaymentCubit, GetPackagePaymentState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              log(purpose!);
              log(target!);
              if (state is GetPaymentLoading) {
                return Center(
                  child: Loading(),
                );
              }
              if (state is SucessGetPayment) {
                packageId = state.getPackageAndCardModel.packages.first.id;

                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tr("service_payment"),
                        style: TextStyles.textViewSemiBold16
                            .copyWith(color: textColor),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        tr("your_payment_100_secure"),
                        style: TextStyles.textViewMedium16
                            .copyWith(color: textColorLight),
                      ),
                      SizedBox(
                        height: 35.h,
                      ),
                      ListView.builder(
                          itemCount:
                              state.getPackageAndCardModel.packages.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var item =
                                state.getPackageAndCardModel.packages[index];

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                // height: 50,
                                child: GenericField(
                                  labeltext: item.name,
                                  lableColor: textColor,
                                  isEnable: false,
                                  suffixIcon: Text(
                                    "${item.price} ${item.currency}",
                                    style: TextStyles.textViewMedium18
                                        .copyWith(color: primary),
                                  ),
                                ),
                              ),
                            );
                          }),
                      SizedBox(
                        height: 30.h,
                      ),
                      Text(
                        tr("card_details"),
                        style: TextStyles.textViewMedium16
                            .copyWith(color: textColor),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      state.getPackageAndCardModel.cards.isEmpty
                          ? Center(child: Text(tr("no_cards")))
                          : Container(
                              child: CardListPaymentWidget(
                              cards: state.getPackageAndCardModel.cards,
                            )),
                      SizedBox(
                        height: 20.h,
                      ),
                      AddNewCardButton(
                        listingId: listingId,
                        target: target,
                        purpose: purpose,
                      ),
                      SizedBox(
                        height: 35.h,
                      ),
                      AddPaymentButton(
                        packageId: packageId.toString(),
                        listingId: listingId.toString(),
                        stutas: purpose,
                      ),
                    ],
                  ),
                );
              } else {
                return ErrorScreen();
              }
            },
          ),
        ),
      ),
    );
  }
}
