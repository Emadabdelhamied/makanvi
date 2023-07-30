import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:makanvi_web/core/error/failures.dart';
import 'package:makanvi_web/features/home_buyer/domain/usecase/search_and_filter_usecase.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'dart:ui' as ui;
import '../../../../../core/usecases/usecases.dart';
import '../../../../../core/util/navigator.dart';
import '../../../../../injection_container.dart';
import '../../../../auth/data/models/add_probalty_model.dart';
import '../../../../auth/data/models/get_data_add_probalty_model.dart';
import '../../../../auth/domain/usecases/get_proparty_usecase.dart';
import '../../../../seller_pages/listining_seller/data/models/my_listings_all_model.dart';
import '../../../../seller_pages/listining_seller/presentation/pages/property_details.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(
      {required this.getSearchUseCase, required this.getPropartyDataUsecase})
      : super(SearchInitial());
  final GetSearchUseCase getSearchUseCase;
  final GetPropartyDataUsecase getPropartyDataUsecase;
  bool isMore = true;
  int currentpage = 1;
  TextEditingController search = TextEditingController();
  //String search = '';
  int? locationId;
  List searchDataList = [];
  Future<void> fGetSearch({
    bool? isFirst,
    int? locationId,
  }) async {
    isMore = isFirst ?? isMore;
    if (isFirst ?? false) {
      currentpage = 1;
    }
    if (isMore) {
      if (currentpage == 1) {
        emit(SearchLoadingState());
        searchDataList = [];
      } else {
        emit(SearchPaginationState());
      }
      final failOrResponse = await getSearchUseCase(
        SearchAndFilterParams(
          search: search.text,
          offerTypeId: perpuse.toString(),
          priceFrom: double.parse(priceRange.start.toString()),
          priceTo: double.parse(priceRange.end.toString()),
          areaFrom: double.parse(areaRange.start.toString()),
          areaTo: double.parse(areaRange.end.toString()),
          types: _propertyIds,
          locationId: locationId ?? locationId,
          amenities: _amenitiesIds,
          features:
              _featuresAdd.firstWhereOrNull((element) => element.count == 0) !=
                      null
                  ? []
                  : _featuresAdd,
          page: currentpage.toString(),
        ),
      );
      failOrResponse.fold(
        (l) {
          if (l is ServerFailure) {
            emit(SearchErrorState(message: l.message));
          }
        },
        (r) {
          //((r.total / 15).ceil() > currentpage)
          if (r.properties.meta.to != null && r.properties.data.isNotEmpty) {
            currentpage++;
          } else {
            isMore = false;
          }

          searchDataList += r.properties.data;
          total = r.total;
          // searchMarkers.clear();
          for (var element in searchDataList) {
            // searchMarkers.add(Marker(
            //   markerId: MarkerId("${element.id}".toString()),
            //   position: LatLng(double.parse(element.location.latitude),
            //       double.parse(element.location.longitude)),
            //   infoWindow: InfoWindow(
            //       title: "${element.currency} ${element.price}",
            //       onTap: () {
            //         sl<AppNavigator>().push(
            //             screen:
            //                 PropertyDetails(listingId: element.id.toString()));
            //       },
            //       snippet:
            //           "${element.location.city},${element.location.state},${element.location.country}"),
            //   icon: markerIcon == null
            //       ? BitmapDescriptor.defaultMarker
            //       : BitmapDescriptor.fromBytes(markerIcon!),
            // ));
          }
          emit(SearchLoadedState(data: r.properties.data));
        },
      );
    }
  }

  int total = 0;
  bool filterEnabled = false;
  bool reseted = false;
  void emptyFilters() {
    filterEnabled = false;
    // searchMarkers.clear();
    priceRange = SfRangeValues(minPrice, maxPrice);
    _featuresAdd = [];
    search.clear();
    total = 0;
    perpuse = 0;
    reseted = true;
    _propertyIds = [];
    _amenitiesIds = [];
    areaRange = SfRangeValues(minArea, maxArea);
    emit(ResetFilter());
    emit(SearchInitial());
  }

  SfRangeValues priceRange = SfRangeValues(0, 100000);
  SfRangeValues areaRange = SfRangeValues(40, 4000);
  int perpuse = 0;
  List<TypeProparty> offerTypesList = [];
  List<TypeProparty> typesList = [];
  List<Amenity> amenitiesList = [];
  List<Amenity> featuresList = [];
  double? minPrice = 0;
  double? maxPrice = 10000000000000000000000;
  double? minArea = 0;
  double? maxArea = 10000000000000000000000;
  Future<void> fGetDataEditPropertyModel() async {
    emit(GetRequiredPropartyLoading());
    final response = await getPropartyDataUsecase(NoParams());

    response.fold(
      (failure) => emit(GetRequiredPropartyError()),
      (success) {
        log(success.toString());
        offerTypesList = success.offerTypes;
        typesList = success.types;
        amenitiesList = success.amenities;
        featuresList = success.features;
        if (minArea == 0) {
          minPrice = success.minPrice;
          maxPrice = success.maxPrice;
          minArea = success.minArea;
          maxArea = success.maxArea;
          areaRange = SfRangeValues(success.minArea, success.maxArea);
          priceRange = SfRangeValues(success.minPrice, success.maxPrice);
        }

        emit(GetRequiredPropartySuccess());
      },
    );
  }

  List<FeatureAddProbalty> _featuresAdd = [];
  List<FeatureAddProbalty> get getFeaturesAdd => _featuresAdd;
  void setFeatureAdd(int id, int count) {
    reseted = false;
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

  List<int> _propertyIds = [];
  List<int>? get getpropertyIds => _propertyIds;
  set setpropertyId(int id) {
    if (_propertyIds.contains(id)) {
      _propertyIds.remove(id);
    } else {
      _propertyIds.add(id);
    }
    log(_propertyIds.toString());
  }

  // Set<Marker> searchMarkers = {};
  Uint8List? markerIcon;
  Future<Uint8List> getBytesFromAsset() async {
    ByteData data = await rootBundle.load('assets/images/markerImage.png');
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: 100);
    ui.FrameInfo fi = await codec.getNextFrame();
    markerIcon = (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
    return markerIcon!;
  }
}
