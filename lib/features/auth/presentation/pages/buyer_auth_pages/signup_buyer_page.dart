import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../bloc/main_cubit/bloc_main_cubit.dart';
import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/styles/styles.dart';
import '../../../../../core/util/navigator.dart';
import '../../../../../core/util/validator.dart';
import '../../../../../core/widgets/appbar_generic.dart';
import '../../../../../core/widgets/button.dart';
import '../../../../../core/widgets/generic_field.dart';
import '../../../../../core/widgets/loading.dart';
import '../../../../../core/widgets/password_field.dart';
import '../../../../../core/widgets/toast.dart';
import '../../../../../injection_container.dart';
import '../../../../home_buyer/presentation/pages/home_main_buyer.dart';
import '../../../../static/presentation/pages/terms.dart';
import '../../../domain/usecases/register_usecase.dart';
import '../../cubit/sign_up_cubit/signup_cubit.dart';
import '../../widgets/social_widget/apple_widget.dart';
import '../../widgets/social_widget/google_widget.dart';
import 'login_buyer_page.dart';
import 'verfiy_phone_buyer_page.dart';

class SignUpBuyerPage extends StatefulWidget {
  const SignUpBuyerPage({Key? key}) : super(key: key);

  @override
  State<SignUpBuyerPage> createState() => _SignUpBuyerPageState();
}

class _SignUpBuyerPageState extends State<SignUpBuyerPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController fullName = TextEditingController();

  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();
  final TextEditingController agancyName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var mainBloc = context.read<BlocMainCubit>();
    return WillPopScope(
      onWillPop: () async {
        await sl<AppNavigator>().pushToFirst(screen: const HomeMainBuyer());
        return false;
      },
      child: BlocProvider(
        create: (BuildContext context) => sl<SignupCubit>(),
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            appBar: AppBarGeneric(
              title: "",
              onPressed: () async {
                await sl<AppNavigator>()
                    .pushToFirst(screen: const HomeMainBuyer());
              },
            ),
            // AppBar(
            //   backgroundColor: Colors.transparent,
            //   elevation: 0.0,
            //   automaticallyImplyLeading: false,
            // ),
            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tr("sign_up"),
                        style: TextStyles.textViewSemiBold16
                            .copyWith(color: titelsColor),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      GenericField(
                        labeltext: tr("full_name"),
                        hintText: tr("full_name"),
                        controller: fullName,
                        validation: (value) => Validator.name(value),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      GenericField(
                        labeltext: tr("email_address"),
                        hintText: tr("email_address"),
                        controller: email,
                        validation: (value) => Validator.email(value),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      PasswordField(
                        labeltext: tr("password"),
                        hintText: tr("password"),
                        controller: password,
                        validation: (value) => Validator.password(value),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: tr("by_clicking_on_sign_you_accept"),
                              style: TextStyles.textViewMedium14
                                  .copyWith(color: textColor),
                            ),
                            const TextSpan(text: ' '),
                            TextSpan(
                              text: tr("terms_and_condition"),
                              style: TextStyles.textViewBold14UndeLine
                                  .copyWith(color: focus),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => sl<AppNavigator>().push(
                                      screen: const TermsAndConditions(),
                                    ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      BlocConsumer<SignupCubit, SignupState>(
                        listener: (context, state) {
                          if (state is RegisterErrorState) {
                            customToast(
                              backgroundColor: Colors.red.shade300,
                              textColor: Colors.white,
                              content: state.error,
                            );
                          }
                          if (state is RegisterSuccessState) {
                            mainBloc.updateData(state.appData);
                            sl<AppNavigator>().push(
                                screen: VerfiyPhoneNumberBuyerPage(
                              modeUser: "buyer",
                            ));
                          }
                        },
                        builder: (context, state) {
                          if (state is RegisterLodingState) {
                            return const Center(child: Loading());
                          } else {
                            return GenericButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<SignupCubit>().fRegister(
                                      registerParams: RegisterParams(
                                        accountType: null,
                                        accountMode: "buyer",
                                        lang: EasyLocalization.of(context)!
                                            .currentLocale!
                                            .languageCode,
                                        countryId: mainBloc.repository
                                            .loadAppData()!
                                            .countryId
                                            .toString(),
                                        email: email.text.trim(),
                                        password: password.text.trim(),
                                        name: fullName.text.trim(),
                                        confirmPassword: password.text.trim(),
                                      ),
                                      context: context);
                                  // sl<AppNavigator>()
                                  //     .push(screen: VerfiyPhoneNumberPage());
                                }
                              },
                              color: primary,
                              width: MediaQuery.of(context).size.width,
                              borderRadius: BorderRadius.circular(15.r),
                              child: Text(
                                tr("sign_up"),
                                style: TextStyles.textViewMedium15
                                    .copyWith(color: white),
                              ),
                            );
                          }
                        },
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            tr("already_register"),
                            style: TextStyles.textViewMedium14
                                .copyWith(color: black),
                          ),
                          const SizedBox(width: 5),
                          InkWell(
                            onTap: () {
                              sl<AppNavigator>().push(screen: LoginBuyerPage());
                            },
                            child: Text(
                              tr("login"),
                              style: TextStyles.textViewMedium14
                                  .copyWith(color: focus),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 35.h,
                      ),
                      const GoogleWidget(
                        isBuyer: true,
                        isLogin: false,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      // if (Platform.isIOS)
                      //   AppleWidget(
                      //     isBuyer: true,
                      //     isLogin: false,
                      //   ),
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
      ),
    );
  }
}
