import 'dart:convert';
import 'dart:developer';

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
import '../../../../seller_pages/listining_seller/domain/usecases/create_listings_usecase.dart';
import '../../../../seller_pages/listining_seller/domain/usecases/direct_upgrade_usecase.dart';
import '../../../../seller_pages/listining_seller/presentation/cubit/direct_upgrade/direct_upgrade_cubit.dart';
import '../../../../seller_pages/payment/presentation/pages/screen_select_shotting_dailog.dart';
import '../../../../settings/presentation/pages/reset_password/change_password.dart';
import '../../../data/models/add_probalty_model.dart';
import '../../../domain/usecases/login_usecase.dart';
import '../../cubit/add_property/add_property_cubit.dart';
import '../../cubit/auth_cubit.dart';
import '../../cubit/login_cubit/login_cubit.dart';
import '../../widgets/social_widget/google_widget.dart';
import '../payment_pages/dialog_sucess_payment_page.dart';
import '../pincode_page/pincode_page.dart';
import '../signup/signup_page.dart';
import '../verfy_phone_numer/verfy_phone_numer_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key, this.isBuyer = false}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final bool isBuyer;
  @override
  Widget build(BuildContext context) {
    var mainCubit = BlocProvider.of<BlocMainCubit>(context, listen: false);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => sl<LoginCubit>(),
        ),
        BlocProvider(
          create: (BuildContext context) => sl<DirectUpgradeCubit>(),
        ),
      ],
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
                          mainCubit.authenticate(state.appData);
                          if (state.appData.phone == "" ||
                              state.appData.phone == null) {
                            sl<AppNavigator>().push(
                                screen: VerfiyPhoneNumberPage(
                              isLogin: false,
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
                            ));

                            // await context
                            // .read<RegisterCubit>()
                            // .fGetOtp(context: context);
                            // AppNavigator.pushToFrist(
                            //     context: context, screen: const PinPage());
                          } else {
                            if (isBuyer == false) {
                              // sl<AppNavigator>()
                              //     .pushToFirst(screen: HomeMainSeller());

                              var data = await HiveHelper.getFromBox(
                                  boxName: BoxNames.addProperty,
                                  key: 'add_property');
                              // final prefs =
                              //     await SharedPreferences.getInstance();
                              if (data != null) {
                                // final jsonData = jsonDecode(
                                //     prefs.getString('add_property') ?? '{}');
                                final jsonData = jsonDecode(data ?? '{}');

                                AddPropartyModel map =
                                    AddPropartyModel.fromJson(jsonData);
                                await context
                                    .read<AuthCubit>()
                                    .fCreateListingsAuth(
                                        createListingParms: CreateListingParms(
                                      creatListingsModel: map.toJsonApi(),
                                    ));
                                log(context
                                    .read<AuthCubit>()
                                    .listingIdValue
                                    .toString());

                                context
                                    .read<AddPropertyCubit>()
                                    .removeAllField();

                                HiveHelper.deleteFromBox(
                                    boxName: BoxNames.addProperty,
                                    key: 'add_property');
                                // prefs.remove("add_property");
                                context
                                    .read<AddPropertyCubit>()
                                    .removeAllField();

                                if (state.goto == "" || state.goto == "pay") {
                                  await sl<AppNavigator>().pushToFirst(
                                      screen: DialogSucessPaymentPage(
                                    listingId: context
                                        .read<AuthCubit>()
                                        .listingIdValue!,
                                    goto: state.goto,
                                  ));
                                } else if (state.goto == "direct_upgrade") {
                                  await context
                                      .read<DirectUpgradeCubit>()
                                      .fDirectUpgrading(
                                        directUpgradeParams:
                                            DirectUpgradeParams(
                                          listingId: context
                                              .read<AuthCubit>()
                                              .listingIdValue!,
                                          packageId: state.packageId.toString(),
                                        ),
                                      );
                                  await sl<AppNavigator>().pushToFirst(
                                      screen: ScreenSelectShottingDateDialog(
                                    listingId: context
                                        .read<AuthCubit>()
                                        .listingIdValue!,
                                  ));
                                  // if (state is DirectUpgradeSuccessState) {
                                }
                              } else {
                                state.appData.modeUserNow == "seller"
                                    ? sl<AppNavigator>().pushToFirst(
                                        screen: const HomeMainSeller())
                                    : sl<AppNavigator>().pushToFirst(
                                        screen: const HomeMainBuyer());
                              }
                            } else {
                              sl<AppNavigator>()
                                  .pushToFirst(screen: const HomeMainBuyer());
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
                          color: primary,
                          width: MediaQuery.of(context).size.width,
                          borderRadius: BorderRadius.circular(15.r),
                          child: Text(
                            tr("login"),
                            style: TextStyles.textViewMedium15
                                .copyWith(color: white),
                          ),
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
                            sl<AppNavigator>().push(screen: SignUpPage());
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
                    const GoogleWidget(isLogin: true),
                    SizedBox(
                      height: 10.h,
                    ),
                    //if (platform.Platform.isIOS) AppleWidget(isLogin: true),
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
