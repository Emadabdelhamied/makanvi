import 'dart:async';

import 'package:easy_localization/easy_localization.dart' as tr;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../bloc/main_cubit/bloc_main_cubit.dart';
import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/styles/styles.dart';
import '../../../../../core/util/navigator.dart';
import '../../../../../core/widgets/appbar_generic.dart';
import '../../../../../core/widgets/button.dart';
import '../../../../../core/widgets/loading.dart';
import '../../../../../core/widgets/toast.dart';
import '../../../../../injection_container.dart';
import '../../cubit/reset_password/reset_password_cubit.dart';
import 'create_new_password.dart';

class ChangePasswordPinCode extends StatefulWidget {
  ChangePasswordPinCode({
    super.key,
    required this.phone,
    required this.code,
    this.isLogin = false,
  });
  final String phone;
  final String code;
  final bool isLogin;

  @override
  State<ChangePasswordPinCode> createState() => _ChangePasswordPinCodeState();
}

class _ChangePasswordPinCodeState extends State<ChangePasswordPinCode> {
  int secondsRemaining = 120;
  bool enableResend = false;
  Timer? timer;

  @override
  initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
        });
      }
    });
  }

  void _resendCode() {
    //other code here
    setState(() {
      secondsRemaining = 120;
      enableResend = false;
    });
  }

  @override
  dispose() {
    timer!.cancel();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  TextEditingController verFicationCode = TextEditingController();
  Map<String, dynamic> creatListingsModel = {};

  @override
  Widget build(BuildContext context) {
    int minutes = (secondsRemaining ~/ 60) % 60;
    int seconds = secondsRemaining % 60;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<SettingsCubit>(),
        ),
      ],

      // create: (context) => sl<PincodeCubit>(),
      child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
              appBar: AppBarGeneric(isback: true),
              body: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tr.tr("phone_verfication"),
                            style: TextStyles.textViewSemiBold16
                                .copyWith(color: textColor),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          RichText(
                            text: TextSpan(
                                text: tr.tr("a_4_digits_verfication_code"),
                                style: TextStyles.textViewMedium15.copyWith(
                                  color: textColorLight,
                                  fontFamily: Localizations.localeOf(context)
                                              .languageCode ==
                                          "en"
                                      ? "Montserrat"
                                      : "Almarai",
                                ),
                                children: [
                                  TextSpan(
                                    text: widget.isLogin
                                        ? "${sl<BlocMainCubit>().repository.loadAppData()!.phone!.replaceRange(0, (sl<BlocMainCubit>().repository.loadAppData()!.phone!.length), "********")}"
                                        : "${sl<BlocMainCubit>().repository.loadAppData()!.phone!.replaceRange(0, (sl<BlocMainCubit>().repository.loadAppData()!.phone!.length), "********")}${sl<BlocMainCubit>().repository.loadAppData()!.phone![sl<BlocMainCubit>().repository.loadAppData()!.phone!.length - 2]}${sl<BlocMainCubit>().repository.loadAppData()!.phone![sl<BlocMainCubit>().repository.loadAppData()!.phone!.length - 1]}",
                                    style: TextStyles.textViewBold14
                                        .copyWith(color: textColor),
                                  )
                                ]),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: PinCodeTextField(
                              length: 4,
                              appContext: context,
                              // controller: _pincodeController,
                              animationType: AnimationType.fade,
                              keyboardType: TextInputType.phone,
                              inputFormatters: const [
                                // FilteringTextInputFormatter.digitsOnly
                              ],
                              enableActiveFill: true,
                              cursorColor: focus,
                              pinTheme: PinTheme(
                                shape: PinCodeFieldShape.box,
                                fieldHeight: 72.h,
                                fieldWidth: 75.w,
                                activeColor: transparentColor,
                                disabledColor: transparentColor,
                                selectedColor: focus,
                                selectedFillColor: white,
                                activeFillColor: gray3,
                                inactiveColor: transparentColor,
                                borderRadius: BorderRadius.circular(10),
                                inactiveFillColor: gray3,
                              ),

                              textInputAction: TextInputAction.done,
                              pastedTextStyle: const TextStyle(
                                color: focus,
                                fontWeight: FontWeight.bold,
                              ),
                              textStyle: TextStyles.textViewSemiBold16
                                  .copyWith(color: textColor),
                              controller: verFicationCode,

                              onChanged: (String value) {},
                              onCompleted: (value) {
                                // log(verFicationCode.text);
                              },
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Enter Pin Code";
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 40.h,
                          ),
                          Center(
                            child: Text(
                              '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                              style: TextStyles.textViewMedium16,
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                tr.tr("didint_recive_code"),
                                style: TextStyles.textViewMedium16
                                    .copyWith(color: black1),
                              ),
                              const SizedBox(width: 5),
                              BlocConsumer<SettingsCubit, SettingsState>(
                                listener: (context, state) {
                                  if (state is RequestOtpSuccessState) {
                                    customToast(
                                      backgroundColor: Colors.green.shade400,
                                      textColor: Colors.white,
                                      content: state.message,
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
                                  return TextButton(
                                    onPressed: enableResend
                                        ? () {
                                            context
                                                .read<SettingsCubit>()
                                                .fRequestOtp(
                                                    phone: widget.phone,
                                                    code: widget.code);
                                            _resendCode();
                                          }
                                        : null,
                                    child: Text(
                                      tr.tr("resend"),
                                      style: TextStyles
                                          .textViewMedium15Underline
                                          .copyWith(
                                              color:
                                                  enableResend ? focus : gray),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 40.h,
                          ),
                          BlocConsumer<SettingsCubit, SettingsState>(
                            listener: (context, state) {
                              if (state is VerifyOtpSuccessState) {
                                customToast(
                                  backgroundColor: Colors.green.shade400,
                                  textColor: Colors.white,
                                  content: state.message,
                                );
                                sl<AppNavigator>().pop();
                                sl<AppNavigator>().push(
                                    screen: CreateNewPassword(
                                  token: context.read<SettingsCubit>().token!,
                                ));
                              }
                              if (state is VerifyOtpErrorState) {
                                customToast(
                                  backgroundColor: Colors.red.shade400,
                                  textColor: Colors.white,
                                  content: state.message,
                                );
                              }
                            },
                            builder: (context, state) {
                              if (state is VerifyOtpLoadingState) {
                                return Loading();
                              } else {
                                return GenericButton(
                                  onPressed: () async {
                                    if (verFicationCode.text.isEmpty) {
                                      customToast(
                                          backgroundColor: red,
                                          textColor: white,
                                          content: "Enter Otp");
                                    } else {
                                      context.read<SettingsCubit>().fVerifyOtp(
                                          phone: widget.phone,
                                          code: widget.code,
                                          otp: verFicationCode.text);
                                    }
                                  },
                                  child: Text(
                                    tr.tr("verify"),
                                    style: TextStyles.textViewMedium15
                                        .copyWith(color: white),
                                  ),
                                  color: primary,
                                  width: MediaQuery.of(context).size.width,
                                  borderRadius: BorderRadius.circular(15.r),
                                );
                              }
                            },
                          ),
                        ]),
                  ),
                ),
              ))),
    );
  }
}
