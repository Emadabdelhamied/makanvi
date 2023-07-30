import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:makanvi_web/features/seller_pages/listining_seller/domain/usecases/get_listing_data_usecase.dart';
import 'package:makanvi_web/features/seller_pages/listining_seller/presentation/cubit/get_one_listing_cubit/get_one_listing_cubit.dart';

import '../../../../../../core/widgets/error_screen.dart';
import '../../../../../../core/widgets/loading.dart';
import '../../../../../../injection_container.dart';
import '../../cubit/edit_property_cubit/edit_property_cubit.dart';
import 'edit_property_first_step.dart';
import 'edit_property_fourth_step.dart';
import 'edit_property_second_step.dart';
import 'edit_property_third_step.dart';

class EditPropertyScreen extends StatelessWidget {
  const EditPropertyScreen(
      {super.key,
      this.isLoged = false,
      this.isPay = true,
      required this.listingId});
  final bool isLoged;
  final bool isPay;
  final String listingId;
  @override
  Widget build(BuildContext context) {
    log(isPay.toString());
    return BlocProvider(
      create: (context) => sl<GetOneListingCubit>()
        ..fGetOneListing(
            getListingDataParams: GetListingDataParams(listingId: listingId)),
      child: Scaffold(
        body: BlocConsumer<GetOneListingCubit, GetOneListingState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is GetOneListingLoading) {
              return Center(
                child: Loading(),
              );
            } else if (state is GetOneListingSuccess) {
              context.read<EditPropertyCubit>().myListingData =
                  state.myListingData;
              context.read<EditPropertyCubit>().setSelectedCurrency =
                  state.myListingData.property.currency;
              return PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: context.read<EditPropertyCubit>().pageController,
                children: [
                  EditPropertyFirstStep(
                    isLoged: isLoged,
                    isPay: isPay,
                    listingId: listingId,
                    title:
                        "${state.myListingData.property.location.city},${state.myListingData.property.location.state},${state.myListingData.property.location.country}",
                    // location: LatLng(
                    //     double.parse(
                    //         state.myListingData.property.location.latitude),
                    // double.parse(state
                    //     .myListingData.property.location.longitude)
                    // )
                  ),
                  EditPropertySecondStep(),
                  EditPropertyThirdStep(),
                  EditPropertyFourthStep(listingId: listingId)
                ],
              );
            } else {
              return ErrorScreen();
            }
          },
          // ),
        ),
      ),
    );
  }
}
