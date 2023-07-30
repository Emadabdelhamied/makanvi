import 'package:dartz/dartz.dart';
import 'package:makanvi_web/features/seller_pages/home_seller/data/models/home_seller_model.dart';

import '../../../../../core/error/failures.dart';

abstract class HomeSellerRepository {
  Future<Either<Failure, HomeSellerModel>> getHomeSeller();
}
