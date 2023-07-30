import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/styles/styles.dart';
import '../../../../../core/util/navigator.dart';
import '../../../../../core/widgets/appbar_generic.dart';
import '../../../../../core/widgets/button.dart';
import '../../../../../core/widgets/error_screen.dart';
import '../../../../../core/widgets/loading.dart';
import '../../../../../core/widgets/phone_generic/phone_generic.dart';
import '../../../../../core/widgets/toast.dart';
import '../../../../../injection_container.dart';
import '../../../domain/usecases/send_otp_phone_usecase.dart';
import '../../cubit/countery_cubit/counery_cubit.dart';
import '../../cubit/verfiy_phone_cubit/verfiy_phone_cubit.dart';
import '../pincode_page/pincode_page.dart';
import '../signup/signup_page.dart';

class VerfiyPhoneNumberPage extends StatelessWidget {
  VerfiyPhoneNumberPage({super.key, this.isLogin = false, this.modeUser});
  final bool isLogin;
  final String? modeUser;
  final _formKey = GlobalKey<FormState>();
  String phoneNumber = '';

  TextEditingController phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<VerfiyPhoneCubit>(),
      child: WillPopScope(
        onWillPop: () async {
          sl<AppNavigator>().push(screen: SignUpPage());
          return false;
        },
        child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Scaffold(
                appBar: AppBarGeneric(
                  isback: true,
                  onPressed: () {
                    sl<AppNavigator>().push(screen: SignUpPage());
                  },
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
                              height: 40.h,
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
                                  controller: phone,
                                  countries:
                                      context.read<CouneryCubit>().countries,
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
                              height: 40.h,
                            ),
                            BlocConsumer<VerfiyPhoneCubit, VerfiyPhoneState>(
                              listener: (context, state) async {
                                if (state is SendOtpPhoneSuccess) {
                                  customToast(
                                      backgroundColor: Colors.green,
                                      textColor: white,
                                      content: state.sendOtpModel.message);
                                  await sl<AppNavigator>().push(
                                      screen: PinCodePage(
                                    mobileCounteryId:
                                        state.sendOtpModel.mobileCountryId,
                                    number: state.sendOtpModel.mobileNumber,
                                    isLogin: isLogin,
                                    modeUser: modeUser,
                                  ));
                                }
                              },
                              builder: (context, state) {
                                if (state is SendOtpPhoneLoading) {
                                  return Center(
                                    child: Loading(),
                                  );
                                }
                                if (state is SendOtpPhoneError) {
                                  customToast(
                                      backgroundColor: red,
                                      textColor: white,
                                      content: state.errorMessage);
                                }
                                return GenericButton(
                                  onPressed: () {
                                    if (phone.text.isEmpty) {
                                      customToast(
                                          backgroundColor: red,
                                          textColor: white,
                                          content: tr("enter_phone"));
                                      // sl<AppNavigator>()
                                      //     .push(screen: PinCodePage());
                                    } else {
                                      context
                                          .read<VerfiyPhoneCubit>()
                                          .fSendOtpPhone(
                                              sendOtpParams: SendOtpParams(
                                                  mobileConteryId: context
                                                      .read<CouneryCubit>()
                                                      .mobileCounteryId
                                                      .toString(),
                                                  validUniq: 1,
                                                  mobileNumber: phone.text));
                                    }
                                  },
                                  child: Text(
                                    tr("verify"),
                                    style: TextStyles.textViewMedium15
                                        .copyWith(color: white),
                                  ),
                                  color: primary,
                                  width: MediaQuery.of(context).size.width,
                                  borderRadius: BorderRadius.circular(15.r),
                                );
                              },
                            ),
                          ]),
                    ),
                  ),
                ))),
      ),
    );
  }
}
