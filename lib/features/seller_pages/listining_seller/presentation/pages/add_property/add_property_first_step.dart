import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../../core/constant/colors/colors.dart';
import '../../../../../../core/constant/styles/styles.dart';
import '../../../../../../core/widgets/appbar_generic.dart';
import '../../../../../../core/widgets/button.dart';
import '../../../../../../core/widgets/toast.dart';
import '../../../../../auth/presentation/cubit/add_property/add_property_cubit.dart';
import '../../../../../auth/presentation/widgets/add_property_widget/counter_property_widget.dart';
import '../../../../../auth/presentation/widgets/add_property_widget/field_location.dart';
import '../../../../../auth/presentation/widgets/precent_widget.dart';

class AddPropertyFirstStep extends StatelessWidget {
  AddPropertyFirstStep(
      {super.key,
      required this.isLoged,
      required this.isPay,
      required this.packageId,
      required this.goTo});
  final _formKey = GlobalKey<FormState>();
  final bool isLoged;
  final bool isPay;
  final int packageId;
  final String goTo;

  @override
  Widget build(BuildContext context) {
    //var location = context.watch<AddPropertyCubit>().getLocation;
    //log(location.toString());
    log(context.read<AddPropertyCubit>().addressTitle);
    return Scaffold(
      appBar: AppBarGeneric(
        isback: true,
        title: tr("add_property"),
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
                  title: tr("property_location"),
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
                  labeltext: tr("location"),
                  hintText:
                      context.watch<AddPropertyCubit>().addressTitle.isEmpty
                          ? tr("location")
                          : context.watch<AddPropertyCubit>().addressTitle,
                  // controller:
                  //     context.watch<AddPropertyCubit>().locationController,
                  isEnable: false,
                  // state: _formKey.currentState,
                  // validation: (value) => Validator.name(value),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  height: 500.h,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.r),
                    color: white,
                  ),
                  // alignment: Alignment.topCenter,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                        ),
                        child: Container(
                          // height: 270.h,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.r),
                            // color: primary,
                          ),
                          alignment: Alignment.center,

                          child: GoogleMap(
                            myLocationButtonEnabled: false,
                            initialCameraPosition: const CameraPosition(
                                target: LatLng(26.06750, 50.55111), zoom: 15),
                            markers: const {
                              // location != null
                              //     ? Marker(
                              //         markerId: MarkerId("".toString()),
                              //         position: context
                              //             .watch<AddPropertyCubit>()
                              //             .getLocation!,
                              //         infoWindow: const InfoWindow(
                              //             title: "", snippet: "_detail"),
                              //         // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.mainColor),
                              //       )
                              //     : const Marker(markerId: MarkerId(""))
                            },
                            zoomControlsEnabled: false,
                            onMapCreated: (GoogleMapController controller) {
                              // controller.setMapStyle(mapStyle);
                            },
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // location == null
                          //     ? null
                          //     : context.read<AddPropertyCubit>().addressTitle =
                          //         "";
                          // context
                          //     .read<AddPropertyCubit>()
                          //     .locationController
                          //     .text = "";
                          // sl<AppNavigator>().pop();
                          // sl<AppNavigator>().push(
                          //     screen: SetLocationScreen(
                          //   myLocationIfSelect: "location",
                          //   isLoged: isLoged,
                          //   isPay: isPay,
                          //   packageId: packageId,
                          //   goTo: goTo,
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
                                tr("set_on_map"),
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
            // if (_formKey.currentState!.validate()) {
            if (context.read<AddPropertyCubit>().addressTitle.isEmpty) {
              customToast(
                  backgroundColor: primary,
                  textColor: white,
                  content: "Please Set Location");
            } else {
              context.read<AddPropertyCubit>().nextPage();
            }
            // }
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
