import 'package:dartz/dartz.dart';
import 'package:makanvi_web/features/seller_pages/home_seller/data/models/home_seller_model.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecases.dart';
import '../repositories/home_seller_repositories.dart';

class HomeSellerUseCase extends UseCase<HomeSellerModel, NoParams> {
  final HomeSellerRepository homeSellerRepository;

  HomeSellerUseCase({
    required this.homeSellerRepository,
  });

  @override
  Future<Either<Failure, HomeSellerModel>> call(NoParams noParams) async {
    return await homeSellerRepository.getHomeSeller();
  }
}
