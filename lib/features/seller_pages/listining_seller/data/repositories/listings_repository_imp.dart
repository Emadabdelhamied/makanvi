import 'package:dartz/dartz.dart';
import 'package:makanvi_web/features/seller_pages/listining_seller/data/models/my_listing_model.dart';
import 'package:makanvi_web/features/seller_pages/listining_seller/domain/usecases/close_property_usecase.dart';
import 'package:makanvi_web/features/seller_pages/listining_seller/domain/usecases/direct_upgrade_usecase.dart';
import 'package:makanvi_web/features/seller_pages/listining_seller/domain/usecases/get_listing_data_usecase.dart';
import 'package:makanvi_web/features/seller_pages/listining_seller/domain/usecases/rate_shotting_usecase.dart';

import '../../../../../core/app/app_repository.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../domain/repositories/listings_repositories.dart';
import '../../domain/usecases/create_listings_usecase.dart';
import '../../domain/usecases/edit_listing_usecase.dart';
import '../datasources/listings_remote_datesource.dart';
import '../models/my_listings_all_model.dart';

class ListingsRepositoryImpl implements ListingsRepository {
  final ListingsDatasource listingsDatasource;
  final AppRepository appRepository;
  ListingsRepositoryImpl(this.appRepository,
      {required this.listingsDatasource});

  @override
  Future<Either<Failure, String>> createListings(
      {required CreateListingParms createListingParms}) async {
    try {
      final addListings = await listingsDatasource.createListing(
          createListingParms: createListingParms,
          token: appRepository.loadAppData()!.token.toString());
      // await local.listingsDatasource(token: user.body.accessToken.toString());
      return Right(addListings);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, GetMyListigsAllModel>> getAllListings() async {
    try {
      final myListings = await listingsDatasource.getListingsAll(
          token: appRepository.loadAppData()!.token.toString());
      // await local.listingsDatasource(token: user.body.accessToken.toString());
      return Right(myListings);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> directUpgrade(
      {required DirectUpgradeParams directUpgradeParams}) async {
    try {
      final directUpgrading = await listingsDatasource.directUpgrading(
          token: appRepository.loadAppData()!.token.toString(),
          directUpgradeParams: directUpgradeParams);
      // await local.listingsDatasource(token: user.body.accessToken.toString());
      return Right(directUpgrading);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, MyListingModel>> getListingById(
      {required GetListingDataParams getListingDataParams}) async {
    try {
      final myListingData = await listingsDatasource.getMyListingById(
          token: appRepository.loadAppData()!.token.toString(),
          getListingDataParams: getListingDataParams);
      // await local.listingsDatasource(token: user.body.accessToken.toString());
      return Right(myListingData);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> editProperty({
    required EditListingDataParams editListingDataParams,
  }) async {
    try {
      final message = await listingsDatasource.editProperty(
          token: appRepository.loadAppData()!.token.toString(),
          editListingDataParams: editListingDataParams);
      // await local.listingsDatasource(token: user.body.accessToken.toString());
      return Right(message);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> closeProperty(
      {required ClosePropertyParams closePropertyParams}) async {
    try {
      final message = await listingsDatasource.closeProperty(
          token: appRepository.loadAppData()!.token.toString(),
          closePropertyParams: closePropertyParams);
      // await local.listingsDatasource(token: user.body.accessToken.toString());
      return Right(message);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> ratingShoot(
      {required RatingShootParams ratingShootParams}) async {
    try {
      final message = await listingsDatasource.rateShotting(
          token: appRepository.loadAppData()!.token.toString(),
          ratingShootParams: ratingShootParams);
      // await local.listingsDatasource(token: user.body.accessToken.toString());
      return Right(message);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
