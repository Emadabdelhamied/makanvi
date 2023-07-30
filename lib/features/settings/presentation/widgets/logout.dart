import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makanvi_web/core/util/api_basehelper.dart';

import '../../../../bloc/main_cubit/bloc_main_cubit.dart';
import '../../../../core/app/app_data.dart';
import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/icons.dart';
import '../../../../core/constant/styles/styles.dart';
import '../../../../core/util/navigator.dart';
import '../../../../injection_container.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../../auth/presentation/pages/buyer_auth_pages/signup_buyer_page.dart';
import '../../../auth/presentation/pages/intro/language_screen.dart';
import 'logout_dialog.dart';

class LogoutCard extends StatelessWidget {
  const LogoutCard({super.key});
  @override
  Widget build(BuildContext context) {
    var isGuest =
        context.watch<BlocMainCubit>().repository.loadAppData()!.isGuestUser;
    final mainBloc = BlocProvider.of<BlocMainCubit>(context, listen: false);
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) async {
        if (state is LogOutSuccessState) {
          mainBloc.updateData(AppData(isLogedOut: true));
          mainBloc.unAuthenticate();
          log("----------------------- ${mainBloc.repository.loadAppData()!.token!}");

          log(ApiBaseHelper().headers.toString());
          // await NotificationService.instance!.deleteToken();
          await await sl<AppNavigator>().pushToFirst(screen: LanguageScreen());
        }
      },
      builder: (context, state) {
        return ListTile(
          onTap: isGuest == true
              ? () {
                  sl<AppNavigator>().push(screen: SignUpBuyerPage());
                }
              : () async {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return const AlertDialog(
                          content: DialogLogoutAccount(),
                        );
                      });
                },
          leading: Container(
            height: 48.h,
            width: 48.w,
            alignment: Alignment.center,
            decoration:
                BoxDecoration(color: transparentColor, shape: BoxShape.circle),
            child: Container(
              height: 25.h,
              width: 25.w,
              child: SvgPicture.asset(
                logoutSvg,
              ),
            ),
          ),
          title: Text(
            isGuest == true ? tr("login_splash") : tr("log_out"),
            style: TextStyles.textViewMedium15.copyWith(color: primary),
          ),
        );
      },
    );
  }
}
