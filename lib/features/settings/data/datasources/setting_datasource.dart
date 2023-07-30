import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:makanvi_web/features/settings/domain/usecases/cancel_subscription_usecase.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/util/api_basehelper.dart';
import '../../../../core/util/end_points.dart';
import '../../../auth/data/models/register_model.dart';
import '../../domain/usecases/notification_status_usecase.dart';
import '../../domain/usecases/request_otp_usecase.dart';
import '../../domain/usecases/reset_password_usecase.dart';
import '../../domain/usecases/update_phone_usecase.dart';
import '../../domain/usecases/update_profile_usecase.dart';
import '../../domain/usecases/verify_new_phone_usecase.dart';
import '../../domain/usecases/verify_otp_usecase.dart';
import '../models/profile_model.dart';
import '../models/update_profile_model.dart';

const String requestOtpApi = 'rp/request_otp';
const String requestPhoneOtpApi = 'mn/send_otp';
const String verifyOtpApi = 'rp/verify_otp';
const String resetPasswordApi = 'rp/reset_password';
const String notificationStatusApi = '/notification_status/edit';
const String profileApi = '/user';
const String cancelSubscriptionApi = 'payment/cancel_subscription_request';
const String updatePhoneApi = 'mn/verify';

abstract class SettingDatasource {
  Future<String> requestOtp(OtpParams params);
  Future<String> requestPhoneOtp(
      {required String token, required phoneParams params});
  Future<String> verifyOtp(VerifyParams params);
  Future<String> resetPassword(ResetPasswordParams params);
  Future<String> notificationStatus(
      {required NotificationStatusParams params, required String token});
  Future<ProfileModel> getProfile({required String token});
  Future<UpdateProfileModel> updateProfile(
      {required ProfileParams params, required String token});
  Future<UserModel> updatePhone(
      {required UpdatePhoneNumberParams params, required String token});
  Future<String> deleteAcount({required String token});
  Future<String> switchUser({required String token});
  Future<String> cancelSubscriptionRequest(
      {required String token, required CancelSubscriptionParams params});
}

class SettingDatasourceImp extends SettingDatasource {
  ApiBaseHelper apiConsumer;
  SettingDatasourceImp({required this.apiConsumer});
  @override
  Future<String> requestOtp(OtpParams params) async {
    try {
      final response = await apiConsumer.post(
        url: "${EndPoints.baseUrl}$requestOtpApi",
        body: {"mobile_country_id": params.code, "mobile_number": params.phone},
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
  Future<String> verifyOtp(VerifyParams params) async {
    try {
      final response = await apiConsumer.post(
        url: "${EndPoints.baseUrl}$verifyOtpApi",
        body: {
          "mobile_country_id": params.code,
          "mobile_number": params.email,
          "otp": params.otp,
        },
      );
      if (response.runtimeType != String) {
        return response["reset_token"];
      } else {
        throw ServerException(message: response);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<String> resetPassword(ResetPasswordParams params) async {
    try {
      final response = await apiConsumer.post(
        url: "${EndPoints.baseUrl}$resetPasswordApi",
        body: {
          "reset_token": params.token,
          "password": params.password,
          "password_confirmation": params.confirmedPassword
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
  Future<String> notificationStatus(
      {required NotificationStatusParams params, required String token}) async {
    try {
      final response = await apiConsumer.post(
        url: "${EndPoints.baseUrl}$notificationStatusApi",
        body: {
          "_method": 'PUT',
          "status": params.status,
        },
        token: token,
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
  Future<ProfileModel> getProfile({required String token}) async {
    try {
      final response = await apiConsumer.get(
          url: "${EndPoints.baseUrl}profile", token: token);
      if (response['profile'] == null) {
        throw ServerException(message: response);
      } else {
        ProfileModel result = ProfileModel.fromJson(response);
        return result;
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<UpdateProfileModel> updateProfile(
      {required ProfileParams params, required String token}) async {
    log(token);
    try {
      FormData? formData;
      if (params.image != null) {
        String fileName = params.image!.path.split('/').last;
        formData = FormData.fromMap({
          "image-param-name": await MultipartFile.fromFile(
            params.image!.path,
            filename: fileName,
          ),
        });
      }

      Map<String, dynamic> body = {
        "_method": 'PUT',
        "name": params.name,
        "email": params.email
        // "profile_photo": formData.files.first.value,
      };
      (params.image != null || formData != null)
          ? body.addAll({
              "profile_photo": formData!.files.first.value,
            })
          : body;
      (params.agencyName == null || params.agencyName!.isEmpty)
          ? body
          : body.addAll({
              "agency_name": params.agencyName,
            });
      final response = await apiConsumer.post(
        url: "${EndPoints.baseUrl}profile",
        body: body,
        token: token,
      );
      if (response.runtimeType == String) {
        throw ServerException(message: response);
      } else {
        UpdateProfileModel result = UpdateProfileModel.fromJson(response);
        return result;
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<UserModel> updatePhone(
      {required UpdatePhoneNumberParams params, required String token}) async {
    try {
      Map<String, String> body = {
        "otp": params.otp!,
        "mobile_country_id": params.countryId,
        "mobile_number": params.phone,
      };

      final response = await apiConsumer.post(
        url: "${EndPoints.baseUrl}${updatePhoneApi}",
        token: token,
        body: body,
      );
      if (response.keys.length == 1) {
        throw ServerException(message: response["message"]);
      } else {
        UserModel result = UserModel.fromJson(response["user"]);
        return result;
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<String> deleteAcount({required String token}) async {
    try {
      final response = await apiConsumer.delete(
        url: "${EndPoints.baseUrl}/delete_account",
        token: token,
      );
      if (response.runtimeType == String) {
        throw ServerException(message: response);
      } else {
        String result = response["message"];
        return result;
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<String> switchUser({required String token}) async {
    try {
      final response = await apiConsumer.get(
        url: "${EndPoints.baseUrl}profile/switch_mode",
        token: token,
      );
      if (response.runtimeType == String) {
        throw ServerException(message: response);
      } else {
        String result = response["message"];
        return result;
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<String> requestPhoneOtp(
      {required String token, required phoneParams params}) async {
    try {
      final response = await apiConsumer.post(
        url: "${EndPoints.baseUrl}$requestPhoneOtpApi",
        token: token,
        body: {
          "mobile_country_id": params.countryId,
          "mobile_number": params.phone,
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
  Future<String> cancelSubscriptionRequest(
      {required String token, required CancelSubscriptionParams params}) async {
    try {
      final response = await apiConsumer.post(
        url: "${EndPoints.baseUrl}$cancelSubscriptionApi",
        token: token,
        body: {
          "package_id": params.pakageId,
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
}
