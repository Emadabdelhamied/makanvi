import 'package:dartz/dartz.dart';
import 'package:makanvi_web/features/seller_pages/listining_seller/domain/usecases/rate_shotting_usecase.dart';

import '../../../../../core/error/failures.dart';
import '../../data/models/my_listing_model.dart';
import '../../data/models/my_listings_all_model.dart';
import '../usecases/close_property_usecase.dart';
import '../usecases/create_listings_usecase.dart';
import '../usecases/direct_upgrade_usecase.dart';
import '../usecases/edit_listing_usecase.dart';
import '../usecases/get_listing_data_usecase.dart';

abstract class ListingsRepository {
  Future<Either<Failure, String>> createListings(
      {required CreateListingParms createListingParms});
  Future<Either<Failure, String>> directUpgrade(
      {required DirectUpgradeParams directUpgradeParams});
  Future<Either<Failure, String>> editProperty({
    required EditListingDataParams editListingDataParams,
  });
  Future<Either<Failure, String>> closeProperty({
    required ClosePropertyParams closePropertyParams,
  });
  Future<Either<Failure, MyListingModel>> getListingById(
      {required GetListingDataParams getListingDataParams});
  Future<Either<Failure, GetMyListigsAllModel>> getAllListings();
  Future<Either<Failure, String>> ratingShoot(
      {required RatingShootParams ratingShootParams});
}
