import 'dart:developer';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/util/api_basehelper.dart';
import '../../../../../core/util/end_points.dart';
import '../../domain/usecase/add_payment_intent_usecase.dart';
import '../../domain/usecase/get_package_usecase.dart';
import '../../domain/usecase/select_date_usecase.dart';
import '../models/get_package_model.dart';
import '../models/payment_info.dart';

const String getPaymentApi = 'payment/info/details';

abstract class PaymentDatasource {
  Future<GetPackageAndCardModel> getPackagePayment(
      {required String token, required GetPackageParms getPackageParms});
  Future<PaymentInfoModel> getPaymentInfo({
    required String token,
  });

  Future<String> addCardIntent({required String token});
  Future<String> agancyCreate({required String token});
  Future<String> deleteCardIntent({required String token, required int id});
  Future<String> selectDateShotting(
      {required String token, required SelectDateParms selectDateParms});
  Future<String> addPaymentIntent(
      {required String token,
      required AddIntentPaymentParms addIntentPaymentParms});
}

class PaymentDatasourceImpl implements PaymentDatasource {
  ApiBaseHelper apiConsumer;

  PaymentDatasourceImpl({required this.apiConsumer});

  @override
  Future<GetPackageAndCardModel> getPackagePayment(
      {required String token, required GetPackageParms getPackageParms}) async {
    String url = "cards_and_packages";
    if (getPackageParms.target != null && getPackageParms.purpose != null) {
      url =
          "${url}?target=${getPackageParms.target}&purpose=${getPackageParms.purpose}";
    }
    log(url);
    try {
      final response = await apiConsumer.get(
        url: "${EndPoints.baseUrl}$url",
        token: token,
      );
      GetPackageAndCardModel getPackageAndCardModel =
          GetPackageAndCardModel.fromJson(response);
      if (response == null) {
        throw ServerException(message: response["message"]);
      } else {
        return getPackageAndCardModel;
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<String> addCardIntent({required String token}) async {
    String url = "card/intent";

    log(url);
    try {
      final response = await apiConsumer.get(
        url: "${EndPoints.baseUrl}$url",
        token: token,
      );

      if (response["embed_url"] == null) {
        throw ServerException(message: response["message"]);
      } else {
        return response["embed_url"];
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<String> addPaymentIntent(
      {required String token,
      required AddIntentPaymentParms addIntentPaymentParms}) async {
    String url = "payment/intent";
    Map<String, dynamic> body = {
      "package_id": addIntentPaymentParms.packageId,
      "listing_id": addIntentPaymentParms.listingId,
    };
    if (addIntentPaymentParms.cardId != "null") {
      body.addAll({
        "card_id": addIntentPaymentParms.cardId,
      });
    }
    log(url);
    try {
      final response = await apiConsumer.post(
          url: "${EndPoints.baseUrl}$url", token: token, body: body);

      if (response["message"] == null) {
        throw ServerException(message: response["message"]);
      } else {
        return response["id"];
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<String> deleteCardIntent(
      {required String token, required int id}) async {
    String url = "card/$id";

    log(url);
    try {
      final response = await apiConsumer.delete(
        url: "${EndPoints.baseUrl}$url",
        token: token,
      );

      if (response == null) {
        throw ServerException(message: response["message"]);
      } else {
        return response["message"];
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<String> selectDateShotting(
      {required String token, required SelectDateParms selectDateParms}) async {
    String url = "property/shooting_date/${selectDateParms.id}";
    Map<String, dynamic> body = {
      "_method": "PUT",
      "date": selectDateParms.date,
    };
    log(url);
    try {
      final response = await apiConsumer.post(
          url: "${EndPoints.baseUrl}$url", token: token, body: body);

      if (response["message"] == null) {
        throw ServerException(message: response["message"]);
      } else {
        return response["message"];
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<String> agancyCreate({required String token}) async {
    String url = "agency/request/create";

    log(url);
    try {
      final response = await apiConsumer.get(
        url: "${EndPoints.baseUrl}$url",
        token: token,
      );

      if (response["message"] == null) {
        throw ServerException(message: response["message"]);
      } else {
        return response["message"];
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<PaymentInfoModel> getPaymentInfo({required String token}) async {
    try {
      final response = await apiConsumer.get(
        url: "${EndPoints.baseUrl}$getPaymentApi",
        token: token,
      );
      PaymentInfoModel getPackageAndCardModel =
          PaymentInfoModel.fromJson(response);
      if (response == null) {
        throw ServerException(message: response["message"]);
      } else {
        return getPackageAndCardModel;
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }
}
