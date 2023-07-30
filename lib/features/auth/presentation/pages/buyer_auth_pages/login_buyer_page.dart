import 'dart:convert';
import 'dart:io' as platform;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../bloc/main_cubit/bloc_main_cubit.dart';
import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/styles/styles.dart';
import '../../../../../core/hive/hive_helper.dart';
import '../../../../../core/util/navigator.dart';
import '../../../../../core/util/validator.dart';
import '../../../../../core/widgets/button.dart';
import '../../../../../core/widgets/generic_field.dart';
import '../../../../../core/widgets/loading.dart';
import '../../../../../core/widgets/password_field.dart';
import '../../../../../core/widgets/toast.dart';
import '../../../../../injection_container.dart';
import '../../../../home_buyer/presentation/pages/home_main_buyer.dart';
import '../../../../seller_pages/home_seller/presentation/pages/home_main_seller.dart';
import '../../../../settings/presentation/pages/reset_password/change_password.dart';
import '../../../data/models/update_location_model.dart';
import '../../../domain/usecases/login_usecase.dart';
import '../../../domain/usecases/update_location_usecase.dart';
import '../../cubit/login_cubit/login_cubit.dart';
import '../../cubit/update_location/update_location_cubit.dart';
import '../../widgets/social_widget/apple_widget.dart';
import '../../widgets/social_widget/google_widget.dart';
import '../pincode_page/pincode_page.dart';
import 'verfiy_phone_buyer_page.dart';

class LoginBuyerPage extends StatelessWidget {
  LoginBuyerPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var mainCubit = BlocProvider.of<BlocMainCubit>(context, listen: false);

    return BlocProvider(
      create: (BuildContext context) => sl<LoginCubit>(),
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            automaticallyImplyLeading: false,
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
                      tr("login"),
                      style: TextStyles.textViewSemiBold16
                          .copyWith(color: textColor),
                    ),
                    SizedBox(
                      height: 35.h,
                    ),
                    GenericField(
                      labeltext: tr("email_address"),
                      hintText: tr("email_address"),
                      validation: (value) => Validator.email(value),
                      controller: email,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    PasswordField(
                      labeltext: tr("password"),
                      hintText: tr("password"),
                      validation: (value) => Validator.password(value),
                      controller: password,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    TextButton(
                      onPressed: () {
                        sl<AppNavigator>().push(
                            screen: ChangePassword(
                          isLogin: true,
                        ));
                      },
                      child: Text(
                        tr("forget_password"),
                        style: TextStyles.textViewMedium15Underline
                            .copyWith(color: focus),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    BlocConsumer<LoginCubit, LoginState>(
                      listener: (context, state) async {
                        if (state is LoginSuccessState) {
                          mainCubit.updateData(state.appData);
                          if (state.appData.phone == "" ||
                              state.appData.phone == null) {
                            sl<AppNavigator>().push(
                                screen: VerfiyPhoneNumberBuyerPage(
                              isLogin: true,
                              modeUser: state.appData.modeUserNow,
                            ));
                            // AppNavigator.pushToFrist(
                            //     context: context,
                            //     screen: SecondStepPage(
                            //       name: state.appData.displayName!,
                            //       email: state.appData.email!,
                            //     ));
                          } else if (state.appData.isVerfied == false) {
                            sl<AppNavigator>().push(
                                screen: PinCodePage(
                              mobileCounteryId: mainCubit.repository
                                  .loadAppData()!
                                  .countryId!,
                              number: state.appData.phone!,
                              modeUser: "buyer",
                            ));

                            // await context
                            // .read<RegisterCubit>()
                            // .fGetOtp(context: context);
                            // AppNavigator.pushToFrist(
                            //     context: context, screen: const PinPage());
                          } else {
                            if (state.appData.modeUserNow == "seller") {
                              sl<AppNavigator>()
                                  .pushToFirst(screen: HomeMainSeller());
                            } else {
                              var data = await HiveHelper.getFromBox(
                                  boxName: BoxNames.updateLocation,
                                  key: 'update_location');
                              // final prefs =
                              //     await SharedPreferences.getInstance();
                              // final jsonData = prefs
                              //         .containsKey("update_location")
                              //     ? jsonDecode(
                              //         prefs.getString('update_location') ?? '')
                              //     : "";
                              if (data != null) {
                                final jsonData = jsonDecode(data ?? '{}');

                                UpdateLocationModel map =
                                    UpdateLocationModel.fromJson(jsonData);
                                context
                                    .read<UpdateLocationCubit>()
                                    .fUpdateLocation(
                                        updateLocationParams:
                                            UpdateLocationParams(
                                                countery: map.country,
                                                city: map.city,
                                                state: map.state,
                                                lang: map.longitude,
                                                lat: map.latitude));
                              }
                              // prefs.remove("update_location");

                              HiveHelper.deleteFromBox(
                                  boxName: BoxNames.updateLocation,
                                  key: 'update_location');
                              sl<AppNavigator>()
                                  .pushToFirst(screen: HomeMainBuyer());
                            }

                            // AppNavigator.pushToFrist(
                            //     context: context,
                            //     screen: const HomeMainScreen());
                          }
                        }
                      },
                      builder: (context, state) {
                        if (state is LoginLoadingState) {
                          return const Center(
                            child: Center(
                              child: Loading(),
                            ),
                          );
                        }
                        if (state is LoginErrorState) {
                          customToast(
                            backgroundColor: Colors.red.shade300,
                            textColor: Colors.white,
                            content: state.message,
                          );
                        }
                        return GenericButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<LoginCubit>().fLogin(
                                  loginParams: LoginParams(
                                      email: email.text,
                                      password: password.text));
                            }
                          },
                          child: Text(
                            tr("login"),
                            style: TextStyles.textViewMedium15
                                .copyWith(color: white),
                          ),
                          color: primary,
                          width: MediaQuery.of(context).size.width,
                          borderRadius: BorderRadius.circular(15.r),
                        );
                      },
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          tr("dont_have_account"),
                          style: TextStyles.textViewMedium14
                              .copyWith(color: black),
                        ),
                        const SizedBox(width: 5),
                        InkWell(
                          onTap: () {
                            sl<AppNavigator>().pop();
                          },
                          child: Text(
                            tr("sign_up"),
                            style: TextStyles.textViewMedium14Underline
                                .copyWith(color: focus),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 35.h,
                    ),
                    GoogleWidget(isBuyer: true, isLogin: true),
                    SizedBox(
                      height: 10.h,
                    ),
                    if (platform.Platform.isIOS)
                      AppleWidget(isBuyer: true, isLogin: true),
                    SizedBox(
                      height: 45.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
