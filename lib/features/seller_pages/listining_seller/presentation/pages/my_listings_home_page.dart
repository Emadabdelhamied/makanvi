import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/util/navigator.dart';
import '../../../../../core/widgets/appbar_generic.dart';
import '../../../../../core/widgets/error_screen.dart';
import '../../../../../core/widgets/loading.dart';
import '../../../../../injection_container.dart';
import '../../../../auth/presentation/cubit/add_property/add_property_cubit.dart';
import '../../../home_seller/presentation/cubit/home_cubit.dart';
import '../../../home_seller/presentation/widget/add_listing_button.dart';
import '../cubit/get_listing_cubit/get_listing_cubit.dart';
import '../widgets/my_listings_tab.dart';
import 'add_property/add_property.dart';

class MyListingHomePage extends StatelessWidget {
  const MyListingHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<HomeSellerCubit>().setcurrentIndexSellerHome = 0;

        return false;
      },
      child: BlocProvider(
        create: (context) => sl<GetListingCubit>()..fGetAllListings(),
        child: Scaffold(
          appBar: AppBarGeneric(
            title: tr("my_properties"),
            titleColor: textColor,
            onPressed: () {
              context.read<HomeSellerCubit>().setcurrentIndexSellerHome = 0;
            },
          ),
          body: BlocConsumer<GetListingCubit, GetListingState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              if (state is GetAllListingLoading) {
                return Center(
                  child: Loading(),
                );
              }
              if (state is SucessGetAllListing) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      AddListingButton(
                        onPressed: () {
                          context.read<AddPropertyCubit>().removeAllField();

                          var consume = state.getMyListigsAllModel.subscriptions
                              .listing.consume;
                          var count = state.getMyListigsAllModel.subscriptions
                              .listing.listingCount;
                          bool? _isPay;
                          if (consume >= count) {
                            _isPay = true;
                          } else {
                            _isPay = false;
                          }
                          print(consume >= count);
                          sl<AppNavigator>().push(
                              screen: AddPropertyScreen(
                            isLoged: true,
                            isPay: _isPay,
                            packageId: state
                                .getMyListigsAllModel.subscriptions.listing.id,
                            goTo: state.getMyListigsAllModel.subscriptions
                                .listing.goTo,
                          ));
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      MyListingTab(
                        active: state.getMyListigsAllModel.properities.active,
                        expire: state.getMyListigsAllModel.properities.expired,
                        pending: state.getMyListigsAllModel.properities.pending,
                        subscriptions: state.getMyListigsAllModel.subscriptions,
                      )
                    ],
                  ),
                );
              } else {
                return ErrorScreen();
              }
            },
          ),
        ),
      ),
    );
  }
}
