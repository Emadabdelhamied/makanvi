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
import '../../../../../core/widgets/button.dart';
import '../../../../../core/widgets/generic_field.dart';
import '../../../../../core/widgets/loading.dart';
import '../../../../../core/widgets/password_field.dart';
import '../../../../../core/widgets/toast.dart';
import '../../../../../injection_container.dart';
import '../../../../static/presentation/pages/terms.dart';
import '../../../domain/usecases/register_usecase.dart';
import '../../cubit/sign_up_cubit/signup_cubit.dart';
import '../../widgets/social_widget/google_widget.dart';
import '../login/login_page.dart';
import '../verfy_phone_numer/verfy_phone_numer_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController fullName = TextEditingController();

  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();
  final TextEditingController agancyName = TextEditingController();

  int? _val;

  @override
  Widget build(BuildContext context) {
    var mainBloc = context.read<BlocMainCubit>();
    return BlocProvider(
      create: (BuildContext context) => sl<SignupCubit>(),
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
                      tr("sign_up_screen"),
                      style: TextStyles.textViewSemiBold16
                          .copyWith(color: titelsColor),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      // height: 30.h,
                      child: Row(
                        children: [
                          Expanded(
                            child: RadioListTile(
                              activeColor: primary,
                              value: 0,
                              groupValue: _val,
                              onChanged: (val) {
                                setState(() {
                                  _val = val!;
                                });
                              },
                              contentPadding: EdgeInsets.zero,
                              visualDensity: const VisualDensity(
                                horizontal: VisualDensity.minimumDensity,
                                vertical: VisualDensity.minimumDensity,
                              ),
                              dense: true,
                              title: Text(
                                tr("iam_owner"),
                                style: TextStyles.textViewMedium14
                                    .copyWith(color: black),
                              ),
                            ),
                          ),
                          Expanded(
                            child: RadioListTile(
                              activeColor: primary,
                              value: 1,
                              groupValue: _val,
                              onChanged: (val) {
                                setState(() {
                                  _val = val!;
                                });
                              },
                              contentPadding: EdgeInsets.zero,
                              visualDensity: const VisualDensity(
                                horizontal: VisualDensity.minimumDensity,
                                vertical: VisualDensity.minimumDensity,
                              ),
                              dense: true,
                              title: Text(
                                tr("iam_agent"),
                                style: TextStyles.textViewMedium14
                                    .copyWith(color: black),
                              ),
                            ),
                          )
                        ],
                      ),
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
                      height: _val == 0 ? 0 : 15.h,
                    ),
                    _val == 0
                        ? const SizedBox()
                        : GenericField(
                            labeltext: tr("agancy_name"),
                            hintText: tr("agancy_name"),
                            controller: agancyName,
                            validation: (value) =>
                                Validator.defaultValidator(value),
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
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // TextButton(
                    //     onPressed: () async {
                    //       var data = await HiveHelper.getFromBox(
                    //           boxName: BoxNames.addProperty,
                    //           key: 'add_property');
                    //       if (data == null) {
                    //         log("data");
                    //       }
                    //       log(data);
                    //       var dataconvert = jsonDecode(data);
                    //       log(dataconvert.toString());
                    //       AddPropartyModel map =
                    //           AddPropartyModel.fromJson(dataconvert);
                    //       log(map.city);
                    //     },
                    //     child: Text("testt")),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: tr("by_clicking_on_sign_you_accept"),
                            style: TextStyles.textViewMedium14.copyWith(
                              color: textColor,
                              fontFamily: EasyLocalization.of(context)!
                                          .currentLocale!
                                          .languageCode ==
                                      "en"
                                  ? "Montserrat"
                                  : "Almarai",
                            ),
                          ),
                          const TextSpan(text: ' '),
                          TextSpan(
                            text: tr("terms_and_condition_screen"),
                            style: TextStyles.textViewBold14UndeLine.copyWith(
                              color: focus,
                              fontFamily: EasyLocalization.of(context)!
                                          .currentLocale!
                                          .languageCode ==
                                      "en"
                                  ? "Montserrat"
                                  : "Almarai",
                            ),
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
                          sl<AppNavigator>()
                              .push(screen: VerfiyPhoneNumberPage());
                        }
                      },
                      builder: (context, state) {
                        if (state is RegisterLodingState) {
                          return const Center(child: Loading());
                        } else {
                          return GenericButton(
                            onPressed: () {
                              if (_val == null) {
                                customToast(
                                  backgroundColor: Colors.red.shade300,
                                  textColor: Colors.white,
                                  content: 'you must select type',
                                );
                              } else if (_formKey.currentState!.validate()) {
                                context.read<SignupCubit>().fRegister(
                                    registerParams: RegisterParams(
                                      accountType:
                                          _val == 0 ? "owner" : "agency",
                                      accountMode: "seller",
                                      lang: EasyLocalization.of(context)!
                                          .currentLocale!
                                          .languageCode,
                                      agencyName:
                                          _val == 0 ? null : agancyName.text,
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
                            sl<AppNavigator>().push(screen: LoginPage());
                          },
                          child: Text(
                            tr("login"),
                            style: TextStyles.textViewMedium14Underline
                                .copyWith(color: focus),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 35.h,
                    ),
                    const GoogleWidget(isLogin: false),
                    SizedBox(
                      height: 10.h,
                    ),
                    // if (Platform.isIOS) AppleWidget(isLogin: false),
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
