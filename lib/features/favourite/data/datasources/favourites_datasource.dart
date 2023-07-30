import 'package:makanvi_web/features/favourite/data/models/favourite_model.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/util/api_basehelper.dart';
import '../../../../core/util/end_points.dart';
import '../../domain/usecases/add_to_favorite_usecase.dart';

const String favouriteApi = 'favorite/index';
const String addFavouriteApi = 'favorite/add';
const String removeFavouriteApi = 'favorite/remove';

abstract class FavouriteDatasource {
  Future<FavouritesModel> getFavourites({
    required String token,
  });
  Future<String> addToFavorites(
      {required String token, required AddToFavoritesParams params});
  Future<String> removeFromFavorites(
      {required String token, required AddToFavoritesParams params});
  Future<String> removeAllFavorites({required String token});
}

class FavouriteDatasourceImp extends FavouriteDatasource {
  ApiBaseHelper apiConsumer;
  FavouriteDatasourceImp({required this.apiConsumer});
  @override
  Future<FavouritesModel> getFavourites({required String token}) async {
    try {
      final response = await apiConsumer.get(
        url: "${EndPoints.baseUrl}$favouriteApi",
        token: token,
      );
      FavouritesModel homeBuyerModel = FavouritesModel.fromJson(response);
      if (response == null) {
        throw ServerException(message: response["message"]);
      } else {
        return homeBuyerModel;
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<String> addToFavorites(
      {required String token, required AddToFavoritesParams params}) async {
    try {
      final response = await apiConsumer.get(
        url: "${EndPoints.baseUrl}$addFavouriteApi/${params.id}",
        token: token,
      );
      if (response.runtimeType == String) {
        throw ServerException(message: response);
      } else {
        return response['message'];
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<String> removeFromFavorites(
      {required String token, required AddToFavoritesParams params}) async {
    try {
      final response = await apiConsumer.get(
        url: "${EndPoints.baseUrl}$removeFavouriteApi/${params.id}",
        token: token,
      );
      if (response.runtimeType == String) {
        throw ServerException(message: response);
      } else {
        return response['message'];
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<String> removeAllFavorites({required String token}) async {
    try {
      final response = await apiConsumer.delete(
          url: "${EndPoints.baseUrl}favorite/remove_all", token: token);
      if (response == null) {
        throw ServerException(message: 'error');
      } else {
        return response["message"];
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }
}
