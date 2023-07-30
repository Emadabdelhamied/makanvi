import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:makanvi_web/core/widgets/loading.dart';
import 'package:makanvi_web/core/widgets/toast.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/styles/styles.dart';
import '../../../../../core/util/navigator.dart';
import '../../../../../core/widgets/button.dart';
import '../../../../../injection_container.dart';
import '../../cubit/cancel_subscription_cubit/cancel_subscription_cubit.dart';

class DialogCloseSubscrption extends StatelessWidget {
  final int pakageId;
  const DialogCloseSubscrption({super.key, required this.pakageId});

  @override
  Widget build(BuildContext context) {
    return
        // BlocProvider(
        //   create: (BuildContext context) => sl<DeleteAccountCubit>(),
        //   child:
        Material(
      color: white,
      child: SizedBox(
        height: 250.h,
        width: MediaQuery.of(context).size.width * 0.9,
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
                  Text(
                    tr("package_canclation"),
                    style:
                        TextStyles.textViewMedium16.copyWith(color: textColor),
                    textAlign: TextAlign.center,
                  ),
                  BlocProvider(
                    create: (context) => sl<CancelSubscriptionCubit>(),
                    child: BlocConsumer<CancelSubscriptionCubit,
                        CancelSubscriptionState>(
                      listener: (context, state) {
                        if (state is CancelSubscriptionSuccessState) {
                          customToast(
                              backgroundColor: Colors.green,
                              textColor: white,
                              content: state.message);
                          sl<AppNavigator>().pop();
                        }
                        if (state is CancelSubscriptionErrorState) {
                          customToast(
                              backgroundColor: Colors.red,
                              textColor: white,
                              content: state.message);
                        }
                      },
                      builder: (context, state) {
                        if (state is CancelSubscriptionLoadingState) {
                          return Loading();
                        } else {
                          return GenericButton(
                              width: 220.w,
                              onPressed: () {
                                context
                                    .read<CancelSubscriptionCubit>()
                                    .fCancelSubscriptionRequest(
                                        pakageId: pakageId);
                              },
                              color: primary,
                              height: 45.h,
                              borderRadius: BorderRadius.circular(10),
                              child: Text(
                                tr("cancel_subscription"),
                                style: TextStyles.textViewSemiBold16
                                    .copyWith(color: white),
                              ));
                        }
                      },
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // context.read<DeleteAccountCubit>().fDeleteAccount();
                      sl<AppNavigator>().pop();
                    },
                    child: Text(
                      tr("keep_paln"),
                      style: TextStyles.textViewSemiBold16
                          .copyWith(color: textColor),
                      textAlign: TextAlign.center,
                    ),
                    //     );
                    //   },
                  ),
                ]),
          ],
        ),
      ),
      // ),
    );
  }
}
