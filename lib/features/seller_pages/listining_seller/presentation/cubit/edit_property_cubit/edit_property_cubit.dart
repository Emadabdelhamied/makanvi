import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../../core/error/failures.dart';
import '../../../../../../core/usecases/usecases.dart';
import '../../../../../auth/data/models/add_probalty_model.dart';
import '../../../../../auth/data/models/get_data_add_probalty_model.dart';
import '../../../../../auth/domain/usecases/get_proparty_usecase.dart';
import '../../../data/models/my_listing_model.dart';
import '../../../domain/usecases/edit_listing_usecase.dart';

part 'edit_property_state.dart';

class EditPropertyCubit extends Cubit<EditPropertyState> {
  EditPropertyCubit(
      {required this.editListingDataUseCase,
      required this.getPropartyDataUsecase})
      : super(EditPropertyInitial());
  final GetPropartyDataUsecase getPropartyDataUsecase;
  PageController pageController = PageController();

  void nextPage() {
    pageController.animateToPage(pageController.page!.toInt() + 1,
        duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
  }

  void previousPage() {
    pageController.animateToPage(pageController.page!.toInt() - 1,
        duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
  }

  // LatLng? _setLocation;
  // LatLng? get getLocation => _setLocation;
  // set setLocation(LatLng latLng) {
  //   _setLocation = latLng;
  // }

  String addressTitle = '';
  String countery = '';
  String stateName = '';
  String city = '';
  //arabic
  String counteryAr = '';
  String stateNameAr = '';
  String cityAr = '';
  String lat = '';
  String long = '';
  late TextEditingController locationController = TextEditingController();

  // Future<void> setAddressTitle(String coordinates, String local) async {
  //   emit(SettingNewAddressTitle());
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
  //   lat = coordinates.split(',')[0];
  //   long = coordinates.split(',')[1];
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
  //   locationController.text = addressTitle;
  //   _setLocation = LatLng(double.parse(lat), double.parse(long));
  //   emit(SetNewAddressTitle());
  // }

  void emptyCubitData() {
    addressTitle = '';
    locationController.clear();
    // _setLocation = null;
    price.clear();
    finalAmenitites.clear();
    featuresAdd.clear();
    area.clear();
    descrptionEn.clear();
    selectedAmenites.clear();
  }

  List<TypeProparty> offerTypesList = [];
  List<TypeProparty> typesList = [];
  List<Amenity> amenitiesList = [];
  List<Amenity> featuresList = [];
  List<String> currencyList = [];

  String _selectedCurrency = 'BHD';

  String get selectedCurrency => _selectedCurrency;
  set setSelectedCurrency(val) {
    _selectedCurrency = val;
    emit(SetCurrencyState());
    emit(EditPropertyInitial());
  }

  Future<void> fGetDataEditPropertyModel() async {
    emit(GetEditPropartyLoading());
    final response = await getPropartyDataUsecase(NoParams());

    response.fold(
      (failure) => emit(GetEditPropartyError()),
      (success) {
        log(success.toString());
        offerTypesList = success.offerTypes;
        typesList = success.types;
        amenitiesList = success.amenities;
        featuresList = success.features;
        currencyList = success.currencies;
        emit(GetEditPropartySuccess());
        // emit(OnBoardingInitial());
      },
    );
  }

  MyListingModel? myListingData;
  List finalAmenitites = [];
  List<int> selectedAmenites = [];
  List<int> getSelectedAmenites() {
    finalAmenitites = [];
    selectedAmenites = [];
    myListingData!.property.amenities!.forEach((element) {
      if (selectedAmenites.contains(element.id) == false) {
        finalAmenitites.add(element.id);
        selectedAmenites
            .add(amenitiesList.indexWhere((x) => x.id == element.id));
      }
    });
    return selectedAmenites;
  }

  int? selectedOfferType;
  int getSelectedOfferType() {
    return offerTypesList.indexWhere((element) {
      if (element.id == myListingData!.property.offerType!.id) {
        log(element.title);
        selectedOfferType = element.id;
        log(selectedOfferType.toString());
      }

      return element.id == myListingData!.property.offerType!.id;
    });
  }

  int? selectedType;
  int getSelectedType() {
    return typesList.indexWhere((element) {
      selectedType = element.id;

      return element.id == myListingData!.property.type!.id;
    });
  }

  TextEditingController price = TextEditingController();
  TextEditingController area = TextEditingController();
  TextEditingController descrptionEn = TextEditingController();
  List<FeatureAddProbalty> featuresAdd = [];
  void createFeaturesList() {
    featuresAdd = [];
    myListingData!.property.features!.forEach((element) {
      featuresAdd.add(FeatureAddProbalty(id: element.id, count: element.count));
    });
  }

  void incrementCounterList(int i) {
    featuresAdd[i].count++;
  }

  void decrementCounterList(int i) {
    if (featuresAdd[i].count >= 1) {
      featuresAdd[i].count--;
    }
  }

  final EditListingDataUseCase editListingDataUseCase;
  Future<void> fEditListing({required String listingId}) async {
    emit(EditPropartyLoading());
    final response = await editListingDataUseCase(
      EditListingDataParams(
        selectedOfferType: selectedOfferType.toString(),
        currency: _selectedCurrency == "د.ب" ? "BHD" : _selectedCurrency,
        selectedType: selectedType.toString(),
        area: area.text.isEmpty
            ? myListingData!.property.area.toString()
            : area.text,
        price: price.text.isEmpty
            ? myListingData!.property.price.toString()
            : price.text,
        amenities: finalAmenitites,
        features: featuresAdd,
        city: city.isEmpty ? myListingData!.property.location.city : city,
        country: countery.isEmpty
            ? myListingData!.property.location.country
            : countery,
        cityAr: cityAr.isEmpty ? '' : cityAr,
        countryAr: counteryAr.isEmpty ? '' : counteryAr,
        stateAr: stateNameAr.isEmpty ? '' : stateNameAr,
        date: myListingData!.property.shootingDate ?? '',
        description: descrptionEn.text.isEmpty
            ? myListingData!.property.description
            : descrptionEn.text,
        isNegotiable: myListingData!.property.isNegotiable,
        latitude: lat.isEmpty ? myListingData!.property.location.latitude : lat,
        longitude:
            long.isEmpty ? myListingData!.property.location.longitude : long,
        state: stateName.isEmpty
            ? myListingData!.property.location.state
            : stateName,
        listingId: listingId,
      ),
    );

    response.fold(
      (failure) {
        if (failure is ServerFailure) {
          emit(EditPropartyError(message: failure.message));
        }
      },
      (success) {
        log(success.toString());

        emit(EditPropartySuccess(message: success));
      },
    );
  }
}
