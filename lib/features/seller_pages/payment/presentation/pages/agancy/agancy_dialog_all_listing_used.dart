import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/constant/colors/colors.dart';
import '../../../../../../core/constant/styles/styles.dart';
import '../../../../../../core/util/navigator.dart';
import '../../../../../../core/widgets/button.dart';
import '../../../../../../core/widgets/loading.dart';
import '../../../../../../core/widgets/toast.dart';
import '../../../../../../injection_container.dart';
import '../../../../home_seller/presentation/cubit/home_cubit.dart';
import '../../../../home_seller/presentation/pages/home_main_seller.dart';
import '../../cubit/agancy_create/agancy_create_cubit.dart';

class AgancyDialogAllListingUsed extends StatelessWidget {
  const AgancyDialogAllListingUsed({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 400.h,
        width: double.maxFinite,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                // height: 97.h,
                // width: 97.w,
                // decoration: BoxDecoration(
                //   color: Color(0xff11CF74).withOpacity(0.15),
                //   shape: BoxShape.circle,
                //   // borderRadius: BorderRadius.circular(4.r),
                //   // image: DecorationImage(image: AssetImage(searchFieldIcon)),
                // ),
                backgroundColor: primary.withOpacity(0.15),
                radius: 50.r,
                child: CircleAvatar(
                  radius: 30.r,
                  backgroundColor: primary,
                  child: Icon(
                    Icons.warning,
                    color: white,
                  ),
                ),
              ),
              Text(
                tr("all_of_your_listing_credit_has_been_used"),
                style: TextStyles.textViewBold15.copyWith(color: textColor),
                textAlign: TextAlign.center,
              ),
              // SizedBox(
              //   height: 20.h,
              // ),
              Text(
                tr("request_additinal_credit_to_publish_more_listings"),
                style: TextStyles.textViewMedium13.copyWith(color: textColor),
                textAlign: TextAlign.center,
              ),
              BlocProvider(
                create: (context) => sl<AgancyCreateCubit>(),
                child: BlocConsumer<AgancyCreateCubit, AgancyCreateState>(
                  listener: (context, state) async {
                    if (state is ErrorAgancyCreate) {
                      customToast(
                          backgroundColor: red,
                          textColor: textColor,
                          content: state.message);
                    }
                    if (state is SucessAgancyCreate) {
                      context
                          .read<HomeSellerCubit>()
                          .setcurrentIndexSellerHome = 1;
                      sl<AppNavigator>().push(screen: HomeMainSeller());
                    }
                  },
                  builder: (context, state) {
                    if (state is AgancyCreateLoading) {
                      return Loading();
                    }
                    return GenericButton(
                      onPressed: () {
                        context.read<AgancyCreateCubit>().fAgancyCreate();
                      },
                      child: Text(
                        tr("request_credit"),
                        style: TextStyles.textViewSemiBold16
                            .copyWith(color: white),
                      ),
                      color: primary,
                      width: MediaQuery.of(context).size.width,
                      borderRadius: BorderRadius.circular(15.r),
                    );
                  },
                ),
              ),

              Center(
                child: TextButton(
                    onPressed: () {
                      context
                          .read<HomeSellerCubit>()
                          .setcurrentIndexSellerHome = 1;
                      sl<AppNavigator>().push(screen: HomeMainSeller());
                    },
                    child: Text(
                      tr("no_thanks"),
                      style:
                          TextStyles.textViewSemiBold16.copyWith(color: black),
                    )),
              )
            ]));
  }
}
