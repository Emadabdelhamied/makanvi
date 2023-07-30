import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../../core/constant/colors/colors.dart';
import '../../../../../../core/constant/styles/styles.dart';
import '../../../../../../core/widgets/appbar_generic.dart';
import '../../../../../../core/widgets/button.dart';
import '../../../../../auth/presentation/widgets/add_property_widget/counter_property_widget.dart';
import '../../../../../auth/presentation/widgets/add_property_widget/field_location.dart';
import '../../../../../auth/presentation/widgets/precent_widget.dart';
import '../../cubit/edit_property_cubit/edit_property_cubit.dart';

class EditPropertyFirstStep extends StatelessWidget {
  EditPropertyFirstStep({
    super.key,
    required this.isLoged,
    required this.isPay,
    // required this.location,
    required this.title,
    required this.listingId,
  });
  final _formKey = GlobalKey<FormState>();
  final bool isLoged;
  final bool isPay;
  // final LatLng location;
  final String title;
  final String listingId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGeneric(
        // isback: true,
        title: tr('edit_property'),
        titleColor: textColor,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                CounterWidget(
                  title: tr('property_location'),
                  count: tr("1"),
                ),
                SizedBox(
                  height: 10.h,
                ),
                const PrecentWidget(
                  percent: 0.25,
                ),
                SizedBox(
                  height: 20.h,
                ),
                FieldLocation(
                  labeltext: tr('location'),
                  hintText:
                      context.watch<EditPropertyCubit>().addressTitle.isEmpty
                          ? title
                          : context.watch<EditPropertyCubit>().addressTitle,
                  isEnable: false,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  height: 300.h,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.r),
                    color: primary,
                  ),
                  // alignment: Alignment.topCenter,
                  child: Stack(
                    children: [
                      // ClipRRect(
                      //   borderRadius: BorderRadius.only(
                      //     topLeft: Radius.circular(30),
                      //     topRight: Radius.circular(30),
                      //     bottomRight: Radius.circular(30),
                      //     bottomLeft: Radius.circular(30),
                      //   ),
                      //   child: Container(
                      //     // height: 270.h,
                      //     width: MediaQuery.of(context).size.width,
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(30.r),
                      //       // color: primary,
                      //     ),
                      //     alignment: Alignment.center,
                      //     child:
                      //         context.watch<EditPropertyCubit>().getLocation ==
                      //                 null
                      //             ? GoogleMap(
                      //                 myLocationButtonEnabled: false,
                      //                 initialCameraPosition: CameraPosition(
                      //                     target: location, zoom: 15),
                      //                 markers: {
                      //                   Marker(
                      //                     markerId: MarkerId("".toString()),
                      //                     position: location,
                      //                     infoWindow: InfoWindow(
                      //                         title: "", snippet: "_detail"),
                      //                     // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.mainColor),
                      //                   )
                      //                 },
                      //                 zoomControlsEnabled: false,
                      //                 onMapCreated:
                      //                     (GoogleMapController controller) {
                      //                   // controller.setMapStyle(mapStyle);
                      //                 },
                      //               )
                      //             : GoogleMap(
                      //                 myLocationButtonEnabled: false,
                      //                 //key: ,
                      //                 initialCameraPosition: CameraPosition(
                      //                     target: context
                      //                         .watch<EditPropertyCubit>()
                      //                         .getLocation!,
                      //                     zoom: 15),
                      //                 markers: {
                      //                   Marker(
                      //                     markerId: MarkerId("id".toString()),
                      //                     position: context
                      //                         .watch<EditPropertyCubit>()
                      //                         .getLocation!,
                      //                     infoWindow: InfoWindow(
                      //                         title: "", snippet: "_detail"),
                      //                     // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.mainColor),
                      //                   )
                      //                 },
                      //                 zoomControlsEnabled: false,
                      //                 onMapCreated:
                      //                     (GoogleMapController controller) {
                      //                   // controller.setMapStyle(mapStyle);
                      //                 },
                      //               ),
                      //   ),
                      // ),
                      InkWell(
                        onTap: () {
                          // sl<AppNavigator>().push(
                          //     screen: SetEditLocationScreen(
                          //   myLocationIfSelect:
                          //       context.read<EditPropertyCubit>().getLocation ==
                          //               null
                          //           ? location
                          //           : context
                          //               .read<EditPropertyCubit>()
                          //               .getLocation!,
                          //   isLoged: isLoged,
                          //   isPay: isPay,
                          // ));
                        },
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                              height: 40.h,
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(30.r),
                                    bottomRight: Radius.circular(30.r)),
                                color: white.withOpacity(0.4),
                              ),
                              child: Text(
                                tr('set_on_map'),
                                style: TextStyles.textViewMedium16
                                    .copyWith(color: textColor),
                              )),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding:
            EdgeInsets.only(bottom: 35.h, right: 20.w, left: 20.w, top: 20.h),
        child: GenericButton(
          onPressed: () {
            context.read<EditPropertyCubit>().nextPage();
          },
          borderRadius: BorderRadius.circular(15.sp),
          color: primary,
          width: 336.w,
          child: Text(
            tr("next"),
            style: TextStyles.textViewSemiBold16.copyWith(color: white),
          ),
        ),
      ),
    );
  }
}
