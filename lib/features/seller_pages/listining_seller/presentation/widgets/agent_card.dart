import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../bloc/main_cubit/bloc_main_cubit.dart';
import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/icons.dart';
import '../../../../../core/constant/styles/styles.dart';
import '../../../../../core/util/end_points.dart';
import '../../../../../core/util/navigator.dart';
import '../../../../../injection_container.dart';
import '../../../../auth/presentation/pages/buyer_auth_pages/signup_buyer_page.dart';
import '../../../../chat/presentation/cubit/chat_cubit.dart';
import '../../../../chat/presentation/pages/chat_screen.dart';
import '../../data/models/my_listing_model.dart';

class AgentCard extends StatelessWidget {
  final PropertyUser user;
  final String listingId;
  const AgentCard({super.key, required this.user, required this.listingId});
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85.h,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: cardBackground,
      ),
      child: Padding(
        padding: const EdgeInsets.all(9),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 67.r,
              child: CircleAvatar(
                radius: 67.r,
                backgroundImage: user.profilePhotoPath.contains("http")
                    ? NetworkImage(user.profilePhotoPath)
                    : NetworkImage(
                        EndPoints.baseImages + user.profilePhotoPath),
              ),
            ),
            SizedBox(
              width: 8.w,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 100.w,
                  child: Text(user.name,
                      style: TextStyles.textViewSemiBold14
                          .copyWith(color: titelsColor)),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(user.agencyName == null ? '' : user.agencyName,
                    style: TextStyles.textViewSemiBold11
                        .copyWith(color: titelsColor)),
              ],
            ),
            SizedBox(
              width: 15.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: user.id ==
                          sl<BlocMainCubit>().repository.loadAppData()!.phone
                      ? null
                      : sl<BlocMainCubit>()
                                  .repository
                                  .loadAppData()!
                                  .isGuestUser ==
                              true
                          ? () {
                              sl<AppNavigator>()
                                  .push(screen: SignUpBuyerPage());
                            }
                          : () async {
                              _makePhoneCall(user.mobileCountry.countryCode +
                                  user.mobileNumber);
                            },
                  child: Container(
                    height: 50.h,
                    width: 50.h,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: user.mobileNumber ==
                                sl<BlocMainCubit>()
                                    .repository
                                    .loadAppData()!
                                    .phone
                            ? disabled
                            : primary),
                    child: SvgPicture.asset(CallSvg,
                        color: white,
                        height: 20.h,
                        width: 20.w,
                        fit: BoxFit.scaleDown),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                BlocConsumer<ChatCubit, ChatState>(
                  listener: (context, state) {
                    if (state is GetChannelIdSuccessLoadingState) {
                      sl<AppNavigator>().push(
                          screen: ChatScreen(
                        channelID: int.parse(state.messageSuccess),
                        name: user.name,
                        imagePath: user.profilePhotoPath,
                        propertyId: int.parse(listingId),
                      ));
                    }
                  },
                  builder: (context, state) {
                    return InkWell(
                      onTap: user.mobileNumber ==
                              sl<BlocMainCubit>()
                                  .repository
                                  .loadAppData()!
                                  .phone
                          ? null
                          : sl<BlocMainCubit>()
                                      .repository
                                      .loadAppData()!
                                      .isGuestUser ==
                                  true
                              ? () {
                                  sl<AppNavigator>()
                                      .push(screen: SignUpBuyerPage());
                                }
                              : () {
                                  context
                                      .read<ChatCubit>()
                                      .fgetChannelId(userId: user.id);
                                },
                      child: Container(
                        height: 50.h,
                        width: 50.h,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: user.mobileNumber ==
                                        sl<BlocMainCubit>()
                                            .repository
                                            .loadAppData()!
                                            .phone
                                    ? disabled
                                    : primary),
                            color: white),
                        child: SvgPicture.asset(chatIconSvg,
                            color: user.mobileNumber ==
                                    sl<BlocMainCubit>()
                                        .repository
                                        .loadAppData()!
                                        .phone
                                ? disabled
                                : primary,
                            height: 20.h,
                            width: 20.w,
                            fit: BoxFit.scaleDown),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
