import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/styles/styles.dart';
import '../../../../../core/util/navigator.dart';
import '../../../../../core/widgets/button.dart';
import '../../../../../core/widgets/loading.dart';
import '../../../../../core/widgets/toast.dart';
import '../../../../../injection_container.dart';
import '../../../home_seller/presentation/cubit/home_cubit.dart';
import '../../../home_seller/presentation/pages/home_main_seller.dart';
import '../../domain/usecase/select_date_usecase.dart';
import '../cubit/select_date_cubit/select_date_cubit.dart';
import 'list_view_date.dart';

class DialogSelectShotting extends StatelessWidget {
  const DialogSelectShotting({super.key, required this.listingId});
  final String listingId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<SelectDateCubit>(),
      child: SizedBox(
        height: 385.h,
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
                backgroundColor: Color(0xff11CF74).withOpacity(0.15),
                radius: 50.r,
                child: CircleAvatar(
                  radius: 30.r,
                  backgroundColor: Color(0xff11CF74),
                  child: Text(
                    "✓",
                    style: TextStyles.textViewRegular25.copyWith(color: white),
                  ),
                ),
              ),
              Text(
                tr("your_payment_was_sucess"),
                style: TextStyles.textViewBold15.copyWith(color: textColor),
                textAlign: TextAlign.center,
              ),
              // SizedBox(
              //   height: 20.h,
              // ),
              Text(
                tr("please_select_your_preferred_date"),
                style: TextStyles.textViewMedium15.copyWith(color: textColor),
                textAlign: TextAlign.center,
              ),
              ListViewDate(),
              BlocConsumer<SelectDateCubit, SelectDateState>(
                listener: (context, state) {
                  if (state is SucessSelectDate) {
                    context.read<HomeSellerCubit>().setcurrentIndexSellerHome =
                        1;
                    sl<AppNavigator>().push(screen: HomeMainSeller());
                  }
                  if (state is ErrorSelectDate) {
                    customToast(
                        backgroundColor: red,
                        textColor: white,
                        content: state.message);
                  }
                },
                builder: (context, state) {
                  if (state is SelectDateLoading) {
                    return Center(
                      child: Loading(),
                    );
                  }
                  return GenericButton(
                      width: 220.w,
                      onPressed: () {
                        log(context.read<SelectDateCubit>().date.toString());

                        context.read<SelectDateCubit>().fSelectDateShotting(
                            selectDateParms: SelectDateParms(
                                id: int.parse(listingId),
                                date: context
                                    .read<SelectDateCubit>()
                                    .date
                                    .toString()));
                      },
                      color: primary,
                      height: 45.h,
                      borderRadius: BorderRadius.circular(10),
                      child: Text(
                        tr("select"),
                        style: TextStyles.textViewSemiBold16
                            .copyWith(color: white),
                      ));
                },
              ),
            ]),
      ),
    );
  }
}
