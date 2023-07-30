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
import '../cubit/close_property_cubit/close_property_cubit.dart';

class DialogClose extends StatelessWidget {
  const DialogClose({super.key, required this.listingId});
  final int listingId;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210.h,
      width: double.maxFinite,
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              sl<AppNavigator>().pop();
            },
            child: Align(
              alignment: Alignment.topRight,
              child: Icon(Icons.close),
            ),
          ),
          Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  tr("would_you_like_to_request_close"),
                  style: TextStyles.textViewMedium15.copyWith(color: textColor),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10.h,
                ),
                BlocProvider(
                    create: (context) => sl<ClosePropertyCubit>(),
                    child: BlocConsumer<ClosePropertyCubit, ClosePropertyState>(
                      listener: (context, state) {
                        if (state is ClosePropertySuccess) {
                          sl<AppNavigator>().pop();
                          customToast(
                              backgroundColor: Colors.green,
                              textColor: white,
                              content: state.message);
                          context
                              .read<HomeSellerCubit>()
                              .setcurrentIndexSellerHome = 1;
                          sl<AppNavigator>()
                              .pushToFirst(screen: HomeMainSeller());
                        }
                      },
                      builder: (context, state) {
                        if (state is ClosePropertyLoading) {
                          return Loading();
                        } else {
                          return GenericButton(
                              width: 220.w,
                              onPressed: () {
                                context
                                    .read<ClosePropertyCubit>()
                                    .fCloseProperty(
                                        listingId: listingId.toString());
                              },
                              color: primary,
                              // height: 45.h,
                              borderRadius: BorderRadius.circular(10),
                              child: Text(
                                tr("request_close"),
                                style: TextStyles.textViewSemiBold16
                                    .copyWith(color: white),
                              ));
                        }
                      },
                    )),
                TextButton(
                    onPressed: () {
                      sl<AppNavigator>().pop();
                    },
                    child: Text(
                      tr("keep_property"),
                      style:
                          TextStyles.textViewSemiBold16.copyWith(color: black),
                    ))
              ]),
        ],
      ),

      // ),
    );
  }
}
