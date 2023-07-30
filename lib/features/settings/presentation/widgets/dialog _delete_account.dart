import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:makanvi_web/bloc/main_cubit/bloc_main_cubit.dart';
import 'package:makanvi_web/core/app/app_data.dart';
import 'package:makanvi_web/core/constant/colors/colors.dart';
import 'package:makanvi_web/core/constant/styles/styles.dart';

import '../../../../core/widgets/button.dart';
import '../../../../core/widgets/toast.dart';
import '../../../../injection_container.dart';
import '../cubit/delete_account_cubit/delete_account_cubit.dart';

class DialogDeleteAccount extends StatelessWidget {
  const DialogDeleteAccount({super.key});

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
                  "Are You Sure You Want to delete your account ?",
                  style: TextStyles.textViewMedium15.copyWith(color: textColor),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "You won't to be able to login with the same account after deleting it!",
                  style:
                      TextStyles.textViewRegular13.copyWith(color: textColor),
                  textAlign: TextAlign.center,
                ),
                GenericButton(
                    onPressed: () {
                      // AppNavigator.pop(context: context);
                    },
                    color: primary,
                    height: 45.h,
                    borderRadius: BorderRadius.circular(10),
                    child: Text(
                      "Keep my Account",
                      style:
                          TextStyles.textViewRegular12.copyWith(color: white),
                    )),
                BlocConsumer<DeleteAccountCubit, DeleteAccountState>(
                  listener: (context, state) {
                    if (state is DeleteAccountSuccessState) {
                      customToast(
                          backgroundColor: Colors.red.shade300,
                          textColor: Colors.white,
                          content: state.message);
                      context.read<BlocMainCubit>().unAuthenticate();
                      context
                          .read<BlocMainCubit>()
                          .updateData(AppData(isGuestUser: true));
                      // AppNavigator.pushToFrist(
                      //     context: context, screen: LoginPage());
                    }
                  },
                  builder: (context, state) {
                    if (state is DeleteAccountLoadingState) {
                      const Center(
                          // child: Loading(),
                          );
                    }
                    return InkWell(
                      onTap: () {
                        context.read<DeleteAccountCubit>().fDeleteAccount();
                      },
                      child: Text(
                        "Yes, i am sure ",
                        style: TextStyles.textViewBold12.copyWith(color: red),
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                ),
              ]),
        ),
      ),
    );
  }
}
