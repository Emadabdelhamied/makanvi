import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:makanvi_web/core/util/navigator.dart';
import 'package:makanvi_web/core/widgets/loading.dart';
import 'package:makanvi_web/injection_container.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/styles/styles.dart';
import '../../../../../core/util/validator.dart';
import '../../../../../core/widgets/button.dart';
import '../../../../../core/widgets/password_field.dart';
import '../../../../../core/widgets/toast.dart';
import '../../cubit/reset_password/reset_password_cubit.dart';

class CreateNewPassword extends StatelessWidget {
  CreateNewPassword({
    super.key,
    required this.token,
  });
  final _formKey = GlobalKey<FormState>();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final String token;
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
                    tr("reset_password"),
                    style:
                        TextStyles.textViewRegular25.copyWith(color: textColor),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  PasswordField(
                    labeltext: tr("password"),
                    hintText: tr("password"),
                    controller: password,
                    validation: (value) => Validator.password(value),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  PasswordField(
                    labeltext: tr("Confirm password"),
                    hintText: tr("Confirm password"),
                    controller: confirmPassword,
                    validation: (value) =>
                        Validator.confirmPassword(value, password.text),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Center(
                      child: BlocConsumer<SettingsCubit, SettingsState>(
                    listener: (context, state) {
                      if (state is ResetPasswordSuccessState) {
                        customToast(
                          backgroundColor: Colors.green.shade400,
                          textColor: Colors.white,
                          content: state.message,
                        );
                        sl<AppNavigator>().pop();
                      }
                      if (state is ResetPasswordErrorState) {
                        customToast(
                          backgroundColor: Colors.red.shade400,
                          textColor: Colors.white,
                          content: state.message,
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is ResetPasswordLoadingState) {
                        return Loading();
                      } else {
                        return GenericButton(
                          width: 336.w,
                          color: primary,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              context.read<SettingsCubit>().fResetPassword(
                                    password: password.text,
                                    confirmedPassword: confirmPassword.text,
                                    token: token,
                                  );
                            }
                          },
                          borderRadius: BorderRadius.circular(10),
                          child: Text(
                            tr("reset_password"),
                            style: TextStyles.textViewBold16,
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
