import 'package:makanvi_web/core/util/api_basehelper.dart';
import 'package:makanvi_web/core/util/end_points.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/usecases/become_partner.dart';
import '../../domain/usecases/contact_us.dart';

const String becomePartenerApi = '/partner_request';
const String contactUsApi = 'inquiry';
const String aboutUsApi = 'static_page/about_us';
const String termsAndConditionsApi = 'static_page/terms_and_conditions';
const String privacyAndPolicyApi = 'static_page/privacy_and_policy';

abstract class StaticDatasource {
  Future<String> becomePartener(BecomePartenerParams params, String userEmail);
  Future<String> contactWithUs(
    ContactWithUsParams params,
  );

  Future<String> aboutUs();
  Future<String> termsAndConditions();
  Future<String> privacyAndPolicy();
}

class StaticDatasourceImp extends StaticDatasource {
  ApiBaseHelper apiConsumer;
  StaticDatasourceImp({
    required this.apiConsumer,
  });
  @override
  Future<String> becomePartener(
      BecomePartenerParams params, String userEmail) async {
    try {
      final response = await apiConsumer.post(
        url: "${EndPoints.baseUrl}$becomePartenerApi",
        body: {
          "name": params.name,
          "contact_email": params.contactEmail,
          "user_email": userEmail,
          "mobile_country_id": params.mobileContryId,
          "mobile_number": params.mobileNumber,
          "message": params.message,
        },
      );
      if (response.runtimeType != String) {
        return response["message"];
      } else {
        throw ServerException(message: response);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<String> contactWithUs(
    ContactWithUsParams params,
  ) async {
    try {
      final response = await apiConsumer.post(
        url: "${EndPoints.baseUrl}$contactUsApi",
        body: {
          "name": params.name,
          "email": params.email,
          "message": params.message,
        },
      );
      if (response.runtimeType != String) {
        return response["message"];
      } else {
        throw ServerException(message: response);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<String> aboutUs() async {
    try {
      final response = await apiConsumer.get(
        url: "${EndPoints.baseUrl}$aboutUsApi",
      );
      if (response.runtimeType != String) {
        return response["page_content"];
      } else {
        throw ServerException(message: response);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<String> privacyAndPolicy() async {
    try {
      final response = await apiConsumer.get(
        url: "${EndPoints.baseUrl}$privacyAndPolicyApi",
      );
      if (response.runtimeType != String) {
        return response["page_content"];
      } else {
        throw ServerException(message: response);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<String> termsAndConditions() async {
    try {
      final response = await apiConsumer.get(
        url: "${EndPoints.baseUrl}$termsAndConditionsApi",
      );
      if (response.runtimeType != String) {
        return response["page_content"];
      } else {
        throw ServerException(message: response);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }
}
