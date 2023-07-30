import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:makanvi_web/core/constant/colors/colors.dart';
import 'package:makanvi_web/core/constant/styles/styles.dart';

import '../../../../../core/util/navigator.dart';
import '../../../../../core/widgets/button.dart';
import '../../../../../core/widgets/error_screen.dart';
import '../../../../../core/widgets/loading.dart';
import '../../../../../core/widgets/phone_generic/phone_generic.dart';
import '../../../../../core/widgets/toast.dart';
import '../../../../../injection_container.dart';
import '../../../../auth/presentation/cubit/countery_cubit/counery_cubit.dart';
import '../../cubit/reset_password/reset_password_cubit.dart';
import 'change_password_pin_code.dart';

class ChangePassword extends StatelessWidget {
  final bool isLogin;
  ChangePassword({super.key, required this.isLogin});
  final _formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SettingsCubit>(),
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: white,
          elevation: 0,
          iconTheme: const IconThemeData(
            color: textColor, //change your color here
          ),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr("verify_phone"),
                    style: TextStyles.textViewSemiBold16
                        .copyWith(color: textColor),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  BlocConsumer<CouneryCubit, CouneryState>(
                      listener: (context, state) {
                    // TODO: implement listener
                  }, builder: (context, state) {
                    if (state is GetCounteryLoading) {
                      return Center(
                        child: Loading(),
                      );
                    }
                    if (state is GetCounterySuccess) {
                      return IntlPhoneFieldCustom(
                        controller: email,
                        countries: context.read<CouneryCubit>().countries,
                        onCountryChanged: (value) {
                          context
                              .read<CouneryCubit>()
                              .setCountryId(code: value.code);
                          log(context
                              .read<CouneryCubit>()
                              .mobileCounteryId
                              .toString());
                        },
                        // validator: (value) =>
                        //     Validator.numbers(value!.number),
                      );
                    } else {
                      return ErrorScreen();
                    }
                  }),
                  SizedBox(
                    height: 30.h,
                  ),
                  Center(
                      child: BlocConsumer<SettingsCubit, SettingsState>(
                    listener: (context, state) {
                      if (state is RequestOtpSuccessState) {
                        customToast(
                          backgroundColor: Colors.green.shade400,
                          textColor: Colors.white,
                          content: state.message,
                        );
                        sl<AppNavigator>().pop();
                        sl<AppNavigator>().push(
                          screen: ChangePasswordPinCode(
                            phone: email.text.trim(),
                            code: context
                                .read<CouneryCubit>()
                                .mobileCounteryId
                                .toString(),
                            isLogin: isLogin,
                          ),
                        );
                      }
                      if (state is RequestOtpErrorState) {
                        customToast(
                          backgroundColor: Colors.red.shade400,
                          textColor: Colors.white,
                          content: state.message,
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is RequestOtpLoadingState) {
                        return const Loading();
                      } else {
                        return GenericButton(
                          width: 336.w,
                          color: primary,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              context.read<SettingsCubit>().fRequestOtp(
                                  phone: email.text.trim(),
                                  code: context
                                      .read<CouneryCubit>()
                                      .mobileCounteryId
                                      .toString());
                            }
                          },
                          borderRadius: BorderRadius.circular(10),
                          child: Text(
                            tr("next"),
                            style: TextStyles.textViewMedium15,
                          ),
                        );
                      }
                    },
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
