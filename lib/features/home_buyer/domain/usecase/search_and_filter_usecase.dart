import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecases.dart';
import '../../data/models/search_model.dart';
import '../repositories/home_buyer_repositories.dart';

class GetSearchUseCase extends UseCase<SearchModel, SearchAndFilterParams> {
  final HomeBuyerRepository homeBuyerRepository;

  GetSearchUseCase({
    required this.homeBuyerRepository,
  });

  @override
  Future<Either<Failure, SearchModel>> call(SearchAndFilterParams parms) async {
    return await homeBuyerRepository.getSearchandFilter(
      searchAndFilterParams: parms,
      page: parms.page,
    );
  }
}

class SearchAndFilterParams {
  final String search;
  final String offerTypeId;
  final String page;
  final double priceFrom;
  final double priceTo;
  final double areaFrom;
  final double areaTo;
  final List types;
  final List amenities;
  final List features;
  final int? locationId;
  SearchAndFilterParams({
    required this.search,
    required this.offerTypeId,
    required this.priceFrom,
    required this.priceTo,
    required this.areaFrom,
    required this.areaTo,
    required this.types,
    required this.amenities,
    required this.features,
    required this.page,
    this.locationId,
  });
}
