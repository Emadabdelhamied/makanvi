import '../../../../../core/error/exceptions.dart';
import '../../../../../core/util/api_basehelper.dart';
import '../../../../../core/util/end_points.dart';
import '../models/home_seller_model.dart';

abstract class HomeSellerDatasource {
  Future<HomeSellerModel> getHomeSeller({required String token});
}

class HomeSellerDatasourceImpl implements HomeSellerDatasource {
  ApiBaseHelper apiConsumer;

  HomeSellerDatasourceImpl({required this.apiConsumer});
  @override
  Future<HomeSellerModel> getHomeSeller({required String token}) async {
    try {
      final response = await apiConsumer.get(
        url: "${EndPoints.baseUrl}home/seller",
        token: token,
      );
      HomeSellerModel homeSellerModel = HomeSellerModel.fromJson(response);
      if (response == null) {
        throw ServerException(message: response["message"]);
      } else {
        return homeSellerModel;
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }
}
