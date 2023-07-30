import 'dart:developer';

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
import '../../../../../core/widgets/error_screen.dart';
import '../../../../../core/widgets/loading.dart';
import '../../../../../injection_container.dart';
import '../../cubit/on_boarding_cubit/on_boarding_cubit.dart';
import '../../widgets/countery_list.dart';
import '../login/login_page.dart';
import '../login/select_login_or_signup_screen.dart';
import 'on_boarding_screen.dart';
import 'select_role.dart';

// List<CountryAuth> countries = [
//   CountryAuth(
//     id: 1,
//     countryCode: "973",
//     flagLocal: FlagsCode.BH,
//     title: "Bahrain",
//     isActive: 1,
//   ),
//   CountryAuth(
//     id: 2,
//     code: "973",
//     flagLocal: FlagsCode.SA,
//     title: "KSA",
//     isActive: 0,
//   ),
//   CountryAuth(
//     id: 3,
//     code: "973",
//     flagLocal: FlagsCode.AE,
//     title: "UAE",
//     isActive: 0,
//   ),
//   CountryAuth(
//     id: 1,
//     code: "973",
//     flagLocal: FlagsCode.EG,
//     title: "Egypt",
//     isActive: 1,
//   )
// ];
int? _counterId;

class SelectCountryScreen extends StatelessWidget {
  final bool isDirect;
  const SelectCountryScreen({super.key, this.isDirect = false});

  @override
  Widget build(BuildContext context) {
    var mainBloc = context.read<BlocMainCubit>();
    return WillPopScope(
        onWillPop: () async {
          isDirect
              ? sl<AppNavigator>().push(screen: SelectLoginOrSignupScreen())
              : sl<AppNavigator>().push(screen: OnBoardingScreen());

          return false;
        },
        child: BlocProvider(
            create: (context) => sl<OnBoardingCubit>()..fGetCounterySelect(),
            child: BlocConsumer<OnBoardingCubit, OnBoardingState>(
                listener: (context, state) {
              // TODO: implement listener
            }, builder: (context, state) {
              if (state is GetCounteryLoading) {
                return Scaffold(body: Center(child: Loading()));
              }
              if (state is GetCounterySuccess) {
                context.read<OnBoardingCubit>().setCounterySelectedId =
                    state.counteryModel.countries.first.id;
                log(context
                    .read<OnBoardingCubit>()
                    .counterySelectedId
                    .toString());
                // log(context
                //     .read<OnBoardingCubit>()
                //     .counterySelectedId
                //     .toString());
                return Scaffold(
                  appBar: AppBarGeneric(
                    title: '',
                    onPressed: () {
                      isDirect
                          ? sl<AppNavigator>()
                              .push(screen: SelectLoginOrSignupScreen())
                          : sl<AppNavigator>().push(screen: OnBoardingScreen());
                    },
                  ),
                  body: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            tr("select_country"),
                            style: TextStyles.textViewSemiBold16
                                .copyWith(color: black),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            tr("please_select_countery"),
                            style: TextStyles.textViewMedium14
                                .copyWith(color: black),
                          ),
                          SizedBox(
                            height: 42.h,
                          ),
                          CounteryList(
                            countryAuth: state.counteryModel.countries,
                          )
                        ],
                      ),
                    ),
                  ),
                  bottomNavigationBar: Padding(
                      padding: EdgeInsets.only(
                          bottom: 35.h, right: 20.w, left: 20.w),
                      child: GenericButton(
                        onPressed: () async {
                          mainBloc.setCountryId(context
                              .read<OnBoardingCubit>()
                              .counterySelectedId
                              .toString());
                          // log(context
                          //     .read<OnBoardingCubit>()
                          //     .counterySelectedId
                          //     .toString());
                          // log(mainBloc.repository
                          //     .loadAppData()!
                          //     .countryId
                          //     .toString());
                          !isDirect
                              ? await sl<AppNavigator>()
                                  .push(screen: SelectRoleScreen())
                              : await sl<AppNavigator>()
                                  .pushToFirst(screen: LoginPage());
                        },
                        child: Text(
                          tr("select"),
                          style: TextStyles.textViewSemiBold16
                              .copyWith(color: white),
                        ),
                        borderRadius: BorderRadius.circular(15.sp),
                        color: primary,
                        width: 336.w,
                      )),
                );
              } else {
                return ErrorScreen();
              }
            })));
  }
}
