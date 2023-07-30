import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/icons.dart';
import '../../../../../core/constant/images.dart';
import '../../../../../core/constant/styles/styles.dart';
import '../../../../../core/widgets/appbar_generic.dart';
import '../../../../../core/widgets/error_screen.dart';
import '../../../../../core/widgets/loading.dart';
import '../../../../../core/widgets/toast.dart';
import '../../../../../injection_container.dart';
import '../../../home_seller/presentation/cubit/home_cubit.dart';
import '../../../listining_seller/presentation/widgets/empty_listing.dart';
import '../cubit/notification_cubit/notification_cubit.dart';
import '../widget/card_notifcation.dart';

class NotificationsPage extends StatelessWidget {
  NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: BlocProvider(
        create: (context) => sl<NotificationSellerCubit>()..fGetNotifcation(),
        child: WillPopScope(
          onWillPop: () async {
            context.read<HomeSellerCubit>().setcurrentIndexSellerHome = 0;

            return false;
          },
          child: Scaffold(
            appBar: AppBarGeneric(
              title: tr("notifications"),
              titleColor: textColor,
              actions: [
                BlocConsumer<NotificationSellerCubit, NotificationState>(
                  listener: (context, state) {
                    // TODO: implement listener
                    if (state is SucessDeleteNotification) {
                      customToast(
                          backgroundColor: green,
                          textColor: black,
                          content: state.message);
                    }
                  },
                  builder: (context, state) {
                    if (state is DeleteNotificationLoading) {
                      return Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }
                    return InkWell(
                      onTap: () {
                        context
                            .read<NotificationSellerCubit>()
                            .fDeleteAllNotifcation();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(DeleteSvg),
                      ),
                    );
                  },
                ),
              ],
              onPressed: () {
                context.read<HomeSellerCubit>().setcurrentIndexSellerHome = 0;
              },
            ),
            body: BlocConsumer<NotificationSellerCubit, NotificationState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                if (state is NotificationLoading) {
                  return Loading();
                }
                if (state is SucessNotification) {
                  return (state.notificationModel.recent.isEmpty &&
                          state.notificationModel.older.data.isEmpty)
                      ? Center(
                          child: EmptyListingScreen(
                          text: tr("no_notification"),
                          subText: tr("no_notification_sub"),
                          image: noNotificationsImage,
                        ))
                      : SingleChildScrollView(
                          child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                state.notificationModel.recent.isEmpty
                                    ? SizedBox()
                                    : Text(
                                        tr("recent"),
                                        style: TextStyles.textViewMedium18
                                            .copyWith(color: textColor),
                                      ),
                                state.notificationModel.recent.isEmpty
                                    ? SizedBox()
                                    : ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: state
                                            .notificationModel.recent.length,
                                        itemBuilder: (context, index) {
                                          return CardNotication(
                                            notifcationCalss: state
                                                .notificationModel
                                                .recent[index],
                                          );
                                        }),
                                state.notificationModel.older.data.isEmpty
                                    ? SizedBox()
                                    : Text(
                                        tr("older_notifications"),
                                        style: TextStyles.textViewMedium14
                                            .copyWith(color: textColor),
                                      ),
                                state.notificationModel.older.data.isEmpty
                                    ? SizedBox()
                                    : ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: state.notificationModel.older
                                            .data.length,
                                        itemBuilder: (context, index) {
                                          return CardNotication(
                                            notifcationCalss: state
                                                .notificationModel
                                                .older
                                                .data[index],
                                          );
                                        }),
                              ]),
                        ));
                } else {
                  return ErrorScreen();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
