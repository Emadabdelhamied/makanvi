import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../domain/usecases/update_location_usecase.dart';

part 'update_location_state.dart';

class UpdateLocationCubit extends Cubit<UpdateLocationState> {
  UpdateLocationCubit({required this.updateLocationUsecase})
      : super(UpdateLocationInitial());
  final UpdateLocationUsecase updateLocationUsecase;

  // LatLng? _setLocation;
  // LatLng? get getLocation => _setLocation;
  // set setLocation(LatLng latLng) {
  //   _setLocation = latLng;
  // }

  late TextEditingController locationController = TextEditingController();

  String addressTitle = '';
  // Future<void> setAddressTitle(String coordinates, String local) async {
  //   emit(SettingAddressBuyerTitle());
  //   List<Placemark>? placemarks = await placemarkFromCoordinates(
  //       double.parse(coordinates.split(',')[0]),
  //       double.parse(coordinates.split(',')[1]),
  //       localeIdentifier: local);
  //   List<Placemark>? placemarksEn = await placemarkFromCoordinates(
  //       double.parse(coordinates.split(',')[0]),
  //       double.parse(coordinates.split(',')[1]),
  //       localeIdentifier: "en");
  //   List<Placemark>? placemarksAr = await placemarkFromCoordinates(
  //       double.parse(coordinates.split(',')[0]),
  //       double.parse(coordinates.split(',')[1]),
  //       localeIdentifier: "ar");
  //   addressTitle =
  //       "${placemarks[0].locality},${placemarks[0].administrativeArea},${placemarks[0].country}";
  //   countery = "${placemarksEn[0].country}";
  //   stateName = "${placemarksEn[0].administrativeArea}";
  //   city = "${placemarksEn[0].locality}";
  //   //arabic

  //   counteryAr = "${placemarksAr[0].country}";
  //   stateNameAr = "${placemarksAr[0].administrativeArea}";
  //   cityAr = "${placemarksAr[0].locality}";
  //   locationController.text = addressTitle;
  //   emit(SetAddressBuyerTitle());
  // }

  String countery = '';
  String stateName = '';
  String city = '';
  //arabic
  String counteryAr = '';
  String stateNameAr = '';
  String cityAr = '';
  Future<void> fUpdateLocation(
      {required UpdateLocationParams updateLocationParams}) async {
    emit(UpdateLocationLoading());
    final response = await updateLocationUsecase(updateLocationParams);

    response.fold(
      (failure) => emit(ErrorUpdateLocation()),
      (sucess) {
        emit(SucessUpdateLocation(message: sucess));
        // emit(OnBoardingInitial());
      },
    );
  }
}
