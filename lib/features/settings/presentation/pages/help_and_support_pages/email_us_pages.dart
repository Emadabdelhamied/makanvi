import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
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
import '../../../../../core/widgets/toast.dart';
import '../../../../../injection_container.dart';
import '../../../../static/domain/usecases/contact_us.dart';
import '../../../../static/presentation/cubit/static_cubit.dart';

class EmailUsPage extends StatefulWidget {
  const EmailUsPage({super.key});

  @override
  State<EmailUsPage> createState() => _EmailUsPageState();
}

class _EmailUsPageState extends State<EmailUsPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController(
        text: sl<BlocMainCubit>().repository.loadAppData()!.displayName ?? '');
    TextEditingController emailController = TextEditingController(
        text: sl<BlocMainCubit>().repository.loadAppData()!.email ?? '');
    TextEditingController messageController = TextEditingController();

    final formKey = GlobalKey<FormState>();
    // String? val;
    // List items = ['1', '2', '3'];
    return Scaffold(
        appBar: AppBarGeneric(
          title: tr("email_us"),
          titleColor: textColor,
        ),
        body: BlocProvider(
          create: (context) => sl<StaticCubit>(),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GenericField(
                        labeltext: tr("full_name"),
                        hintText: tr("full_name"),
                        controller: nameController,
                        validation: (value) {
                          return Validator.name(value);
                        },
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      GenericField(
                        labeltext: tr("email_address"),
                        hintText: tr("email_address"),
                        controller: emailController,
                        validation: (value) {
                          return Validator.email(value);
                        },
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      GenericField(
                        hintText: tr("message"),
                        labeltext: tr("message"),
                        controller: messageController,
                        maxLines: 7,
                        validation: (value) {
                          return Validator.defaultEmptyValidator(value);
                        },
                        // helperText: "Maximum 100 words",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      BlocConsumer<StaticCubit, StaticState>(
                        listener: (context, state) {
                          if (state is StaticPagesSuccessState) {
                            customToast(
                                backgroundColor: Colors.green,
                                textColor: white,
                                content: state.message);
                            sl<AppNavigator>().pop();
                          }
                          if (state is StaticPagesErrorState) {
                            customToast(
                                backgroundColor: Colors.red,
                                textColor: white,
                                content: state.message);
                          }
                        },
                        builder: (context, state) {
                          if (state is StaticPagesLoadingState) {
                            return Loading();
                          } else {
                            return GenericButton(
                              onPressed: () {
                                log(nameController.text);
                                if (nameController.text != '' ||
                                    emailController.text != '') {
                                  context.read<StaticCubit>().fEmailUs(
                                      contactWithUsParams: ContactWithUsParams(
                                          name: nameController.text,
                                          email: emailController.text,
                                          message: messageController.text));
                                }
                              },
                              child: Text(
                                tr("send"),
                                style: TextStyles.textViewMedium15
                                    .copyWith(color: white),
                              ),
                              color: primary,
                              width: MediaQuery.of(context).size.width,
                              borderRadius: BorderRadius.circular(15.r),
                            );
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
