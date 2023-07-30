import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/constant/styles/styles.dart';
import '../../../../../core/util/navigator.dart';
import '../../../../../core/widgets/button.dart';
import '../../../../../injection_container.dart';
import '../../../../bloc/main_cubit/bloc_main_cubit.dart';
import '../../../../core/widgets/loading.dart';
import '../../../../core/widgets/toast.dart';
import '../../../home_buyer/presentation/cubit/home_buyer_cubit/home_buyer_cubit.dart';
import '../../../home_buyer/presentation/pages/home_main_buyer.dart';
import '../../../seller_pages/home_seller/presentation/cubit/home_cubit.dart';
import '../../../seller_pages/home_seller/presentation/pages/home_main_seller.dart';
import '../cubit/remove_list_cubit/remove_list_cubit.dart';

class DeleteAllChatDialog extends StatelessWidget {
  const DeleteAllChatDialog({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final modeUser =
        context.read<BlocMainCubit>().repository.loadAppData()!.modeUserNow;
    return SizedBox(
      height: 210.h,
      width: double.maxFinite,
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              sl<AppNavigator>().pop();
            },
            child: Align(
              alignment: Alignment.topRight,
              child: Icon(Icons.close),
            ),
          ),
          Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  tr("delete_all_messages"),
                  style: TextStyles.textViewMedium15.copyWith(color: textColor),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10.h,
                ),
                BlocProvider(
                  create: (context) => sl<RemoveListCubit>(),
                  child: BlocConsumer<RemoveListCubit, RemoveListState>(
                    listener: (context, state) {
                      if (state is RemoveListAllSucess) {
                        customToast(
                            backgroundColor: Colors.green,
                            textColor: white,
                            content: state.message);
                        if (modeUser == "seller") {
                          context
                              .read<HomeSellerCubit>()
                              .setcurrentIndexSellerHome = 3;
                          sl<AppNavigator>()
                              .pushToFirst(screen: HomeMainSeller());
                        }
                      } else {
                        context
                            .read<HomeBuyerCubit>()
                            .setcurrentIndexBuyerHome = 3;
                        sl<AppNavigator>().pushToFirst(screen: HomeMainBuyer());
                      }
                    },
                    builder: (context, state) {
                      if (state is RemoveListAllLoading) {
                        return Loading();
                      } else {
                        return GenericButton(
                            width: 220.w,
                            onPressed: () {
                              context.read<RemoveListCubit>().fRemoveAllList();
                            },
                            color: primary,
                            // height: 45.h,
                            borderRadius: BorderRadius.circular(10),
                            child: Text(
                              tr("Delete All Chats"),
                              style: TextStyles.textViewSemiBold16
                                  .copyWith(color: white),
                            ));
                      }
                    },
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text(
                      tr('No, Keep Chats'),
                      style:
                          TextStyles.textViewSemiBold16.copyWith(color: black),
                    ))
              ]),
        ],
      ),

      // ),
    );
  }
}
