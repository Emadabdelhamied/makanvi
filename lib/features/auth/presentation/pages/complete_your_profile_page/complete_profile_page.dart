import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../bloc/main_cubit/bloc_main_cubit.dart';
import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/styles/styles.dart';
import '../../../../../core/util/navigator.dart';
import '../../../../../core/widgets/appbar_generic.dart';
import '../../../../../core/widgets/button.dart';
import '../../../../../core/widgets/generic_field.dart';
import '../../../../../core/widgets/loading.dart';
import '../../../../../core/widgets/toast.dart';
import '../../../../../injection_container.dart';
import '../../../../seller_pages/listining_seller/presentation/pages/add_property/add_property.dart';
import '../../../domain/usecases/complete_register_usecase.dart';
import '../../cubit/complete_register/complete_register_cubit.dart';
import '../verfy_phone_numer/verfy_phone_numer_page.dart';

class CompleteProfilePage extends StatefulWidget {
  CompleteProfilePage({
    super.key,
    this.isBuyer = false,
  });
  final bool isBuyer;
  @override
  State<CompleteProfilePage> createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends State<CompleteProfilePage> {
  final _formKey = GlobalKey<FormState>();
  int _val = 0;
  late TextEditingController fullName = TextEditingController();
  final TextEditingController agancyName = TextEditingController();
  @override
  void initState() {
    super.initState();
    fullName.text = context
        .read<BlocMainCubit>()
        .repository
        .loadAppData()!
        .displayName
        .toString();
  }

  @override
  Widget build(BuildContext context) {
    var mainBloc = context.read<BlocMainCubit>();
    return BlocProvider(
      create: (BuildContext context) => sl<CompleteRegisterCubit>(),
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
                            tr("complete_your_profile"),
                            style: TextStyles.textViewSemiBold16
                                .copyWith(color: textColor),
                          ),
                          SizedBox(
                            height: 40.h,
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
                            // validation: (value) => Validator.name(value),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          _val == 0
                              ? SizedBox()
                              : GenericField(
                                  labeltext: tr("agancy_name"),
                                  hintText: tr("agancy_name"),
                                  controller: agancyName,
                                  // validation: (value) => Validator.name(value),
                                ),
                          SizedBox(
                            height: 40.h,
                          ),
                          BlocConsumer<CompleteRegisterCubit,
                              CompleteRegisterState>(
                            listener: (context, state) {
                              if (state is CompleteRegisterErrorState) {
                                customToast(
                                  backgroundColor: Colors.red.shade300,
                                  textColor: Colors.white,
                                  content: state.error,
                                );
                              }
                              if (state is CompleteRegisterSuccessState) {
                                mainBloc.updateData(state.appData);
                                if (widget.isBuyer == true) {
                                  sl<AppNavigator>().push(
                                      screen: AddPropertyScreen(
                                    isLoged: true,
                                    isPay: true,
                                  ));
                                } else {
                                  sl<AppNavigator>()
                                      .push(screen: VerfiyPhoneNumberPage());
                                }
                              }
                            },
                            builder: (context, state) {
                              if (state is CompleteRegisterLodingState) {
                                return const Center(child: Loading());
                              } else {
                                return GenericButton(
                                  onPressed: () {
                                    if (fullName.text.isEmpty) {
                                      customToast(
                                        backgroundColor: Colors.red.shade300,
                                        textColor: Colors.white,
                                        content: "Enter Full Name",
                                      );
                                    } else if (_val == 1 &&
                                        agancyName.text.isEmpty) {
                                      customToast(
                                        backgroundColor: Colors.red.shade300,
                                        textColor: Colors.white,
                                        content: "Enter Agancy Name",
                                      );
                                    } else {
                                      context
                                          .read<CompleteRegisterCubit>()
                                          .fCompleteRegister(
                                            completeRegisterParams:
                                                CompleteRegisterParams(
                                              accountType: _val == 0
                                                  ? "owner"
                                                  : "agency",
                                              accountMode: "seller",
                                              lang:
                                                  EasyLocalization.of(context)!
                                                      .currentLocale!
                                                      .languageCode,
                                              agencyName: _val == 0
                                                  ? null
                                                  : agancyName.text,
                                              // countryId: null,
                                              // email:null,
                                              // password: "12345678".trim(),
                                              name: mainBloc.repository
                                                  .loadAppData()!
                                                  .displayName!
                                                  .trim(),
                                              // confirmPassword: password.text.trim(),
                                            ),
                                          );
                                      // sl<AppNavigator>()
                                      //     .push(screen: VerfiyPhoneNumberPage());
                                    }
                                  },
                                  child: Text(
                                    tr("sign_up"),
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
