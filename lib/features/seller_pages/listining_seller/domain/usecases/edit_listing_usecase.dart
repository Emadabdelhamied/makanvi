import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecases.dart';
import '../repositories/listings_repositories.dart';

class EditListingDataUseCase extends UseCase<String, EditListingDataParams> {
  final ListingsRepository listingsRepository;

  EditListingDataUseCase({
    required this.listingsRepository,
  });

  @override
  Future<Either<Failure, String>> call(EditListingDataParams params) async {
    return await listingsRepository.editProperty(editListingDataParams: params);
  }
}

class EditListingDataParams {
  final String selectedOfferType;
  final String selectedType;
  final String area;
  final String price;
  final String country;
  final String state;
  final String city;
  final String countryAr;
  final String stateAr;
  final String cityAr;
  final String latitude;
  final String longitude;
  final List amenities;
  final List features;
  final String description;
  final int isNegotiable;
  final String date;
  final String currency;
  final String listingId;
  EditListingDataParams({
    required this.selectedOfferType,
    required this.selectedType,
    required this.area,
    required this.price,
    required this.amenities,
    required this.features,
    required this.city,
    required this.country,
    required this.date,
    required this.description,
    required this.currency,
    required this.isNegotiable,
    required this.latitude,
    required this.longitude,
    required this.state,
    required this.listingId,
    required this.countryAr,
    required this.cityAr,
    required this.stateAr,
  });
}
