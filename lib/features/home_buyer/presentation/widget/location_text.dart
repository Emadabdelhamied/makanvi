import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../bloc/main_cubit/bloc_main_cubit.dart';
import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/styles/styles.dart';
import '../../../../core/util/navigator.dart';
import '../../../../injection_container.dart';
import '../../../auth/presentation/pages/buyer_auth_pages/shrare_location.dart/set_location_buyer_screen.dart';

class LocationText extends StatelessWidget {
  const LocationText({super.key});

  @override
  Widget build(BuildContext context) {
    var loadDataCubit = context.watch<BlocMainCubit>().repository.loadAppData();
    return (loadDataCubit!.location == null || loadDataCubit.location!.isEmpty)
        ? InkWell(
            onTap: () {
              // sl<AppNavigator>().push(screen: SetLocationBuyerScreen());
            },
            child: Text(
              tr("share_location"),
              style: TextStyles.textViewMedium14.copyWith(color: focus),
            ),
          )
        : InkWell(
            onTap: () {
              // sl<AppNavigator>().push(
              //     screen: SetLocationBuyerScreen(
              //   myLocationIfSelect: LatLng(
              //     double.parse(loadDataCubit.lat!),
              //     double.parse(loadDataCubit.lang!),
              //   ),
              //   isUpdateApi: loadDataCubit.isGuestUser == true ? false : true,
              // ));
            },
            child: Text(
              loadDataCubit.location.toString(),
              style: TextStyles.textViewSemiBold14.copyWith(color: textColor),
            ),
          );
  }
}
