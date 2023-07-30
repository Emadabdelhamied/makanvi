import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../bloc/main_cubit/bloc_main_cubit.dart';
import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/styles/styles.dart';
import '../../../../core/util/navigator.dart';
import '../../../../core/widgets/button.dart';
import '../../../../injection_container.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../cubit/delete_account_cubit/delete_account_cubit.dart';

class DialogLogoutAccount extends StatelessWidget {
  const DialogLogoutAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<DeleteAccountCubit>(),
      child: Material(
        color: white,
        child: SizedBox(
          height: 250.h,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  tr("log_out_sure"),
                  style: TextStyles.textViewMedium15.copyWith(color: textColor),
                  textAlign: TextAlign.center,
                ),
                GenericButton(
                    onPressed: () {
                      context.read<AuthCubit>().fLogout(
                          faceOrGoogle: BlocProvider.of<BlocMainCubit>(context,
                                      listen: false)
                                  .repository
                                  .loadAppData()!
                                  .providerType ??
                              "");
                    },
                    color: primary,
                    height: 45.h,
                    width: 150.w,
                    borderRadius: BorderRadius.circular(10),
                    child: Text(
                      tr("log_out"),
                      style: TextStyles.textViewBold12.copyWith(color: white),
                    )),
                InkWell(
                  onTap: () {
                    sl<AppNavigator>().pop();
                  },
                  child: Text(
                    tr("cancel"),
                    style: TextStyles.textViewBold14UndeLine
                        .copyWith(color: textColor),
                    textAlign: TextAlign.center,
                  ),
                  //     );
                  //   },
                ),
              ]),
        ),
      ),
    );
  }
}
