import 'package:dartz/dartz.dart';

import '../../../../../core/app/app_repository.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../domain/repositories/home_seller_repositories.dart';
import '../datasources/home_seller_remote_datesource.dart';
import '../models/home_seller_model.dart';

class HomeSellerRepositoryImpl implements HomeSellerRepository {
  final HomeSellerDatasource homeSellerDatasource;
  final AppRepository appRepository;
  HomeSellerRepositoryImpl(this.appRepository,
      {required this.homeSellerDatasource});

  @override
  Future<Either<Failure, HomeSellerModel>> getHomeSeller() async {
    try {
      final myListings = await homeSellerDatasource.getHomeSeller(
          token: appRepository.loadAppData()!.token.toString());
      // await local.listingsDatasource(token: user.body.accessToken.toString());
      return Right(myListings);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
