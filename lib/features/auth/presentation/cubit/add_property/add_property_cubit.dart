import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../core/usecases/usecases.dart';
import '../../../../seller_pages/listining_seller/domain/usecases/create_listings_usecase.dart';
import '../../../data/models/add_probalty_model.dart';
import '../../../data/models/get_data_add_probalty_model.dart';
import '../../../domain/usecases/get_proparty_usecase.dart';

part 'add_property_state.dart';

class AddPropertyCubit extends Cubit<AddPropertyState> {
  AddPropertyCubit(
      {required this.getPropartyDataUsecase,
      required this.createListingUseCase})
      : super(AddPropertyInitial());
  final GetPropartyDataUsecase getPropartyDataUsecase;
  final CreateListingUseCase createListingUseCase;
  int _currentStep = 0;
  int get currentStep => _currentStep;
  set setCurrentStep(int value) {
    _currentStep = value;
    emit(SetCurrentStep());
    emit(AddPropertyInitial());
  }

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

  late TextEditingController locationController = TextEditingController();

  String addressTitle = '';
  // Future<void> setAddressTitle(String coordinates, String local) async {
  //   emit(SettingAddressTitle());
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
  //   log(placemarks.toString());
  //   emit(SetAddressTitle());
  // }

  String countery = '';
  String stateName = '';
  String city = '';
  //arabic
  String counteryAr = '';
  String stateNameAr = '';
  String cityAr = '';
  List<int> _amenitiesIds = [];
  List<int>? get getAmenitiesIds => _amenitiesIds;
  set setAmenitiesId(int id) {
    if (_amenitiesIds.contains(id)) {
      _amenitiesIds.remove(id);
    } else {
      _amenitiesIds.add(id);
    }
    log(_amenitiesIds.toString());
  }

  int? _offerTypes;
  int? get offerTypes => _offerTypes;
  set setOfferTypes(int val) {
    _offerTypes = val;
    // emit(SetCurrencyState());
    //emit(AddPropertyInitial());
  }

  // String _hint = "";
  // String get hint => _hint;
  // set setHint(String val) {
  //   _hint = val;
  //   // emit(SetCurrencyState());
  //   // emit(AddPropertyInitial());
  // }

  int? type;

  List<int> _counter = [];
  List<int> get getCounter => _counter;
  void setCounter(int val) {
    _counter.add(val);
    // notifyListeners();
    log(_counter.toString());
  }

  void incrementCounter(int i) {
    _counter[i]++;
  }

  void decrementCounter(int i) {
    if (_counter[i] >= 1) {
      _counter[i]--;
    }
  }

  List<FeatureAddProbalty> _featuresAdd = [];
  List<FeatureAddProbalty> get getFeaturesAdd => _featuresAdd;
  void setFeatureAdd(int id, int count) {
    _featuresAdd.add(FeatureAddProbalty(id: id, count: count));
  }

  void incrementCounterList(int i) {
    _featuresAdd[i].count++;
  }

  void decrementCounterList(int i) {
    if (_featuresAdd[i].count >= 1) {
      _featuresAdd[i].count--;
    }
  }

  TextEditingController price = TextEditingController();
  TextEditingController area = TextEditingController();
  TextEditingController descrptionEn = TextEditingController();

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
    emit(AddPropertyInitial());
  }

  void removeAllField() {
    price.clear();
    area.clear();
    _selectedCurrency = 'BHD';
    descrptionEn.clear();
    // _setLocation = null;
    addressTitle = '';
    _featuresAdd.clear();
    type = null;
    _offerTypes = null;
    _amenitiesIds.clear();
  }

  Future<void> fGetDataAddPropertyModel() async {
    emit(LoadingProparty());
    final response = await getPropartyDataUsecase(NoParams());

    response.fold(
      (failure) => emit(ErrorProparty()),
      (success) {
        log(success.toString());
        offerTypesList = success.offerTypes;
        typesList = success.types;
        amenitiesList = success.amenities;
        featuresList = success.features;
        currencyList = success.currencies;
        emit(SucessProparty(getDataAddPropertyModel: success));
        // emit(OnBoardingInitial());
      },
    );
  }

  Future<void> fCreateListings(
      {required CreateListingParms createListingParms}) async {
    emit(AddPropartyLoading());
    final response = await createListingUseCase(createListingParms);

    response.fold(
      (failure) => emit(ErrorAddProparty()),
      (success) {
        log(success.toString());

        emit(SucessAddProparty(message: success));
        // emit(OnBoardingInitial());
      },
    );
  }
}
