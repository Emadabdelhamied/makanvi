import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:makanvi_web/features/static/presentation/pages/terms.dart';

import '../../../../bloc/main_cubit/bloc_main_cubit.dart';
import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/icons.dart';
import '../../../../core/constant/styles/styles.dart';
import '../../../../core/util/navigator.dart';
import '../../../../core/widgets/appbar_generic.dart';
import '../../../../core/widgets/loading.dart';
import '../../../../injection_container.dart';
import '../../../auth/presentation/pages/complete_your_profile_page/complete_profile_page.dart';
import '../../../home_buyer/presentation/pages/home_main_buyer.dart';
import '../../../seller_pages/home_seller/presentation/pages/home_main_seller.dart';
import '../../../seller_pages/listining_seller/presentation/pages/add_property/add_property.dart';
import '../../../static/presentation/pages/about_us.dart';
import '../../../static/presentation/pages/privacy.dart';
import '../cubit/switch_user_cubit/switch_user_cubit.dart';
import '../widgets/logout.dart';
import '../widgets/settings_widget.dart';
import 'change_lang_page.dart';
import 'help_and_support_pages/help_and_support_page.dart';
import 'package_and_payment_page.dart/package_payment_page.dart';
import 'reset_password/change_password.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  // PanelController panelController = PanelController();ß
  @override
  Widget build(BuildContext context) {
    var isGuest =
        context.watch<BlocMainCubit>().repository.loadAppData()!.isGuestUser;

    var modeUserNow =
        context.watch<BlocMainCubit>().repository.loadAppData()!.modeUserNow;
    var typeUser =
        context.watch<BlocMainCubit>().repository.loadAppData()!.typeUser;
    log(modeUserNow.toString());
    return WillPopScope(
      onWillPop: () async {
        if (modeUserNow != "seller") {
          await sl<AppNavigator>().pushToFirst(screen: HomeMainBuyer());
        } else {
          await sl<AppNavigator>().pushToFirst(screen: HomeMainSeller());
        }

        return true;
      },
      child: Scaffold(
        appBar: AppBarGeneric(
          title: tr("settings"),
          titleColor: textColor,
          onPressed: () async {
            if (modeUserNow != "seller") {
              await sl<AppNavigator>().pushToFirst(screen: HomeMainBuyer());
            } else {
              await sl<AppNavigator>().pushToFirst(screen: HomeMainSeller());
            }
          },
        ),
        body: SingleChildScrollView(
            child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Container(
                  height: modeUserNow != "seller" ? 200.h : 285.h,
                  width: MediaQuery.of(context).size.width,
                  // color: red,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      modeUserNow != "seller"
                          ? SizedBox()
                          : SettingsWidget(
                              icon: cardSvg,
                              text: tr("payment"),
                              onTap: () {
                                sl<AppNavigator>()
                                    .push(screen: PackageAndPaymentPage());
                              },
                              subText: tr("mange_your_payment_method")),
                      SettingsWidget(
                          icon: CallSvg,
                          text: tr("help_and_support"),
                          onTap: () {
                            sl<AppNavigator>()
                                .push(screen: HelpAndSupportPage());
                          },
                          subText: tr("countact_us_for_inquires")),
                      SettingsWidget(
                          icon: langSvg,
                          text: tr("language"),
                          onTap: () {
                            sl<AppNavigator>()
                                .push(screen: ChangeLanguageScreen());
                          },
                          subText: tr("change_application_language")),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                tr("more_option"),
                style: TextStyles.textViewMedium14.copyWith(color: textColor),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Container(
                  height: 300.h,
                  width: MediaQuery.of(context).size.width,
                  // color: red,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BlocProvider(
                        create: (context) => sl<SwitchUserCubit>(),
                        child: BlocConsumer<SwitchUserCubit, SwitchUserState>(
                          listener: (context, state) async {
                            if (state is SwitchUserSuccessState) {
                              if (modeUserNow == "seller") {
                                context
                                    .read<BlocMainCubit>()
                                    .setModeUser("buyer");
                                await sl<AppNavigator>()
                                    .pushToFirst(screen: HomeMainBuyer());
                              } else {
                                context
                                    .read<BlocMainCubit>()
                                    .setModeUser("seller");

                                await sl<AppNavigator>()
                                    .pushToFirst(screen: HomeMainSeller());
                              }
                            }
                          },
                          builder: (context, state) {
                            if (state is SwitchUserLoadingState) {
                              return Center(
                                child: Loading(),
                              );
                            }
                            return SettingsWidget(
                                icon: homeIconSvg,
                                text: modeUserNow != "seller"
                                    ? tr("switch_to_seller_mode")
                                    : tr("switch_to_exploration_mode"),
                                onTap: isGuest == true
                                    ? () {
                                        sl<AppNavigator>()
                                            .push(screen: AddPropertyScreen());
                                      }
                                    : (typeUser == null || typeUser == "")
                                        ? () {
                                            sl<AppNavigator>().push(
                                                screen: CompleteProfilePage(
                                              isBuyer: true,
                                            ));
                                          }
                                        : () {
                                            context
                                                .read<SwitchUserCubit>()
                                                .fSwitchUser();
                                          },
                                subText: "");
                          },
                        ),
                      ),
                      SettingsWidget(
                          icon: privacySvg,
                          text: tr("privacy_ploicy"),
                          onTap: () {
                            sl<AppNavigator>().push(screen: PrivacyAndPolicy());
                          },
                          subText: ""),
                      SettingsWidget(
                          icon: termsIcon,
                          text: tr("terms_and_conditionn"),
                          onTap: () {
                            sl<AppNavigator>()
                                .push(screen: TermsAndConditions());
                          },
                          subText: ""),
                      SettingsWidget(
                          icon: aboutSvg,
                          text: tr("about_app"),
                          onTap: () {
                            sl<AppNavigator>().push(screen: AboutUs());
                          },
                          subText: ""),
                      sl<BlocMainCubit>().repository.loadAppData()!.isGuestUser!
                          ? SizedBox()
                          : SettingsWidget(
                              icon: lockSvg,
                              text: tr("reset_password"),
                              onTap: () {
                                sl<AppNavigator>().push(
                                    screen: ChangePassword(
                                  isLogin: false,
                                ));
                              },
                              subText: ""),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              LogoutCard(),
            ],
          ),
        )),
      ),
    );
  }
}

customDivider() => const Divider(
      thickness: 2,
      color: dividerColor,
    );
