import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/main_cubit/bloc_main_cubit.dart';
import '../../features/auth/auth_inj.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/auth/presentation/cubit/change_name_rent_or_sell/change_name_rent_or_sell_cubit.dart';
import '../../features/auth/presentation/cubit/update_location/update_location_cubit.dart';
import '../../features/auth/presentation/pages/buyer_auth_pages/signup_buyer_page.dart';
import '../../features/auth/presentation/pages/buyer_auth_pages/verfiy_phone_buyer_page.dart';
import '../../features/auth/presentation/pages/intro/language_screen.dart';
import '../../features/auth/presentation/pages/intro/select_role.dart';
import '../../features/auth/presentation/pages/signup/signup_page.dart';
import '../../features/auth/presentation/pages/verfy_phone_numer/verfy_phone_numer_page.dart';
import '../../features/chat/presentation/cubit/chat_cubit.dart';
import '../../features/chat/presentation/cubit/dend_message_cubit/send_message_cubit.dart';
import '../../features/home_buyer/home_buyer_inj.dart';
import '../../features/home_buyer/presentation/pages/home_main_buyer.dart';
import '../../features/seller_pages/home_seller/presentation/pages/home_main_seller.dart';
import '../../features/seller_pages/listining_seller/presentation/cubit/edit_property_cubit/edit_property_cubit.dart';
import '../../injection_container.dart';
import '../constant/colors/colors.dart';
import '../constant/size_config.dart';
import '../splash_screen.dart';
import '../splash_screen_image.dart';
import '../util/api_basehelper.dart';
import 'app_data.dart';
import 'app_inj.dart';

class MakanviApp extends StatelessWidget {
  final String release;
  const MakanviApp({super.key, required this.release});

  @override
  Widget build(BuildContext context) {
    // String? type0;
    return MultiBlocProvider(
        providers: [
          BlocProvider<BlocMainCubit>(
              create: (BuildContext context) => sl<BlocMainCubit>()),
          BlocProvider<EditPropertyCubit>(
              create: (BuildContext context) => sl<EditPropertyCubit>()),
          ...appMainBlocs(context),
          BlocProvider(
            create: (BuildContext context) => sl<AuthCubit>(),
          ),
          BlocProvider(
            create: (BuildContext context) => sl<ChatCubit>(),
          ),
          BlocProvider(
            create: (BuildContext context) => sl<SendMessageCubit>(),
          ),
          BlocProvider(
            create: (BuildContext context) => sl<UpdateLocationCubit>(),
          ),
          BlocProvider(
            create: (BuildContext context) => sl<ChangeNameRentOrSellCubit>(),
          ),
          ...onBoardingBlocs(context),
          ...appHomeBlocs(context)
        ],
        child: BlocConsumer<BlocMainCubit, BlocMainState>(
            listener: (context, state) {
          if (state is UpdateDataState) {
            // log(state.appData.toString());
            // type0 = state.appData.modeUserNow ?? "";
          } else {
            // log(state.props.toString());
          }
        }, builder: (context, state) {
          var bloc = context.read<BlocMainCubit>();
          var type = bloc.repository.loadAppData() == null
              ? ""
              : bloc.repository.loadAppData()!.modeUserNow;
          // log(type.toString());
          Widget currentPage;
          switch (bloc.appState) {
            // case AppState.loggedOut:
            //   currentPage = SelectLoginOrSignupScreen();
            //   break;
            case AppState.notSeenTutorial:
              currentPage = const LanguageScreen();
              break;
            case AppState.guest:
              currentPage = const HomeMainBuyer();

              break;
            case AppState.selectRole:
              currentPage = const SelectRoleScreen();

              break;
            case AppState.authenticated:
              currentPage = (type == "" || type == "seller")
                  ? const HomeMainSeller()
                  : const HomeMainBuyer();

              break;
            case AppState.unauthenticated:
              currentPage = (type == "" || type == "seller")
                  ? const SignUpPage()
                  : const SignUpBuyerPage();
              break;
            case AppState.notCompleted:
              currentPage = (type == "" || type == "seller")
                  ? VerfiyPhoneNumberPage(
                      modeUser: "seller",
                    )
                  : VerfiyPhoneNumberBuyerPage(
                      modeUser: "buyer",
                    );
              break;
            case AppState.notVerified:
              currentPage = VerfiyPhoneNumberPage();
              break;
            default:
              currentPage = Scaffold(
                appBar: AppBar(
                  title: const Text("Loading"),
                ),
              );
          }
          rebuildAllChildren(context);
          sl<ApiBaseHelper>().updateLocalInHeaders(
              EasyLocalization.of(context)!.currentLocale!.languageCode);

          return MaterialApp(
            //  key: UniqueKey(),
            theme: ThemeData(
                appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                ),
                fontFamily:
                    EasyLocalization.of(context)!.currentLocale!.languageCode ==
                            "en"
                        ? "Montserrat"
                        : "Almarai",
                hintColor: black,
                primaryColor: primary,
                scrollbarTheme: const ScrollbarThemeData().copyWith(
                  thumbColor:
                      MaterialStateProperty.all(const Color(0xffff8297)),
                ),
                colorScheme: ColorScheme.fromSwatch()
                    .copyWith(secondary: primary)
                    .copyWith(background: Colors.white)),
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            navigatorKey: int.parse(release) < 11
                ? SplashScreenImage.navigatorKey
                : SplashScreen.navigatorKey,
            routes: const {},
            home:
                //  SplashScreenVideo(
                //   nextPage:
                Builder(
              builder: (context) {
                ScreenUtil.init(context, designSize: const Size(428, 926));
                SizeConfig().init(context);
                return ScreenUtilInit(
                  designSize: const Size(428, 926),
                  minTextAdapt: true,
                  splitScreenMode: true,
                  builder: (BuildContext context, Widget? child) =>
                      int.parse(release) < 11
                          ? SplashScreenImage(nextPage: currentPage)
                          : SplashScreen(nextPage: currentPage),
                );
              },
            ),
          );
        }));
  }
}

void rebuildAllChildren(BuildContext context) {
  void rebuild(Element el) {
    el.markNeedsBuild();
    el.visitChildren(rebuild);
  }

  (context as Element).visitChildren(rebuild);
}
