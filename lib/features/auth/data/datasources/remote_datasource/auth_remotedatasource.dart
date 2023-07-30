import 'dart:developer';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/notification_service/notification_service.dart';
import '../../../../../core/util/api_basehelper.dart';
import '../../../../../core/util/end_points.dart';
import '../../../domain/usecases/complete_register_usecase.dart';
import '../../../domain/usecases/google_usecase.dart';
import '../../../domain/usecases/login_usecase.dart';
import '../../../domain/usecases/register_usecase.dart';
import '../../../domain/usecases/send_otp_phone_usecase.dart';
import '../../../domain/usecases/update_location_usecase.dart';
import '../../../domain/usecases/verify_otp_usecase.dart';
import '../../models/countery_model.dart';
import '../../models/get_data_add_probalty_model.dart';
import '../../models/login_model.dart';
import '../../models/on_boarding_model.dart';
import '../../models/register_model.dart';
import '../../models/send_otp_model.dart';
import '../../models/vefiy_otp_model.dart';

abstract class AuthRemoteDatasource {
  Future<LoginModel> login(LoginParams loginParams);
  Future<RegisterModel> rigester(RegisterParams loginParams);
  Future<RegisterModel> completeRegister(
      CompleteRegisterParams completeRegisterParams, String token);
  Future<String> getOtp({required String token});
  Future<VerfiyOtpModel> verifyOtp(
      VerifyOtpParams verifyOtpParams, String token);
  Future<LoginModel> googleSignIn(GoogleSignInParams googleSignInParams);
  Future<LoginModel> appleSignIn(GoogleSignInParams googleSignInParams);
  Future<String> logout({required String token});
  Future<OnBoardingModel> getOnBoardingData();
  Future<CounteryModel> getCounterySelect({bool isAll = false});
  Future<GetDataAddPropertyModel> getDataAddProparty();
  Future<SendOtpModel> sendOtpPhone(
      {required SendOtpParams sendOtpParams, required String token});
  Future<String> updateLocation(
      {required UpdateLocationParams updateLocationParams,
      required String token});
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  ApiBaseHelper apiConsumer;

  AuthRemoteDatasourceImpl({required this.apiConsumer});

  @override
  Future<LoginModel> login(LoginParams loginParams) async {
    String? pushToken = await NotificationService.instance!.getToken();
    try {
      final response =
          await apiConsumer.post(url: "${EndPoints.baseUrl}email/login", body: {
        "email": loginParams.email.trim(),
        "password": loginParams.password.trim(),
        "fbs_msg_token": pushToken ?? "",
      });
      LoginModel? result;
      if (response.runtimeType != String) {
        result = LoginModel.fromJson(response);
        return result;
      } else {
        throw ServerException(message: response.toString());
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<RegisterModel> rigester(RegisterParams registerParams) async {
    String? pushToken = await NotificationService.instance!.getToken();
    try {
      final response = await apiConsumer.post(
          url: "${EndPoints.baseUrl}complete_register",
          body: {
            "account_type": registerParams.accountType == null
                ? null
                : registerParams.accountType!.trim(),
            "agency_name": registerParams.agencyName == null
                ? null
                : registerParams.agencyName!.trim(),
            "lang": registerParams.lang,
            "country_id": registerParams.countryId ?? null,
            "account_mode": registerParams.accountMode.trim(),
            "name": registerParams.name.trim(),
            "email": registerParams.email ?? null,
            "password": registerParams.password ?? null,
            "password_confirmation": registerParams.password ?? null,
            "fbs_msg_token": pushToken ?? "",
          },
          token: null);
      log(response.runtimeType.toString());
      RegisterModel? result;
      if (response.runtimeType != String) {
        result = RegisterModel.fromJson(response);
        return result;
      } else {
        // log(response.toString());
        //res = response;
        throw ServerException(message: response.toString());
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  // @override
  // Future<CompleteRegisterModel> completeRegister(
  //     CompleteRegisterParams completeRegisterParams, String token) async {
  //   String? pushToken = await NotificationService.instance!.getToken();
  //   try {
  //     final response = await apiConsumer.post(
  //       url: "${EndPoints.baseUrl}$completeRegisterApi",
  //       token: token,
  //       body: {
  //         // "name": completeRegisterParams.name,
  //         // "email": completeRegisterParams.email,
  //         // "password": completeRegisterParams.password,
  //         "country_id": completeRegisterParams.countryId,
  //         "mobile_country_id": completeRegisterParams.mobileCountryId,
  //         "state_id": completeRegisterParams.cityId,
  //         "title_id": completeRegisterParams.titleId,
  //         "speciality_id": completeRegisterParams.specialityId,
  //         "mobile_number": completeRegisterParams.mobileNumber,
  //         "fbs_msg_token": pushToken ?? "",
  //       },
  //     );
  //     CompleteRegisterModel? result;
  //     if (response.runtimeType != String) {
  //       // log(response.runtimeType.toString());
  //       result = CompleteRegisterModel.fromJson(response);
  //       return result;
  //     } else {
  //       throw ServerException(message: response);
  //     }
  //   } on ServerException catch (e) {
  //     throw ServerException(message: e.message);
  //   }
  // }

  @override
  Future<String> getOtp({required String token}) async {
    try {
      final response = await apiConsumer.get(
          url: "${EndPoints.baseUrl}getotp", token: token);
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
  Future<VerfiyOtpModel> verifyOtp(
      VerifyOtpParams verifyOtpParams, String token) async {
    try {
      final response = await apiConsumer.post(
          url: "${EndPoints.baseUrl}mn/verify",
          body: {
            "mobile_country_id": verifyOtpParams.mobileConteryId,
            "mobile_number": verifyOtpParams.mobileNumber,
            "otp": verifyOtpParams.otp,
          },
          token: token);
      //return result;
      VerfiyOtpModel verfiyOtpModel = VerfiyOtpModel.fromJson(response);
      if (response.runtimeType != String) {
        // log(response.runtimeType.toString());
        return verfiyOtpModel;
      } else {
        throw ServerException(message: response);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<LoginModel> googleSignIn(GoogleSignInParams googleSignInParams) async {
    String? pushToken = await NotificationService.instance!.getToken();

    try {
      final response = await apiConsumer.post(
        url: "${EndPoints.baseUrl}google/login",
        //token: '24|fWhX1icE8Ss5sQjBxgcX7aStzfWKyonNCZu0de76',
        body: {
          "access_token": googleSignInParams.token,
          "fbs_msg_token": pushToken ?? "",
          "account_mode": googleSignInParams.accountMode,
          "lang": googleSignInParams.lang,
          "country_id": googleSignInParams.codnteryId,
        },
      );
      LoginModel? result;
      if (response.runtimeType != String) {
        result = LoginModel.fromJson(response);
        return result;
      } else {
        throw ServerException(message: response.toString());
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<LoginModel> appleSignIn(GoogleSignInParams googleSignInParams) async {
    String? pushToken = await NotificationService.instance!.getToken();
    log(pushToken.toString());
    try {
      final response = await apiConsumer.post(
        url: "${EndPoints.baseUrl}apple/login",
        //token: '24|fWhX1icE8Ss5sQjBxgcX7aStzfWKyonNCZu0de76',
        body: {
          "access_token": googleSignInParams.token,
          "fbs_msg_token": pushToken ?? "",
        },
      );
      LoginModel? result;
      if (response.runtimeType != String) {
        result = LoginModel.fromJson(response);
        return result;
      } else {
        throw ServerException(message: response.toString());
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<String> logout({required String token}) async {
    try {
      final response = await apiConsumer.get(
          url: "${EndPoints.baseUrl}logout", token: token);
      if (response["message"] == null) {
        throw ServerException(message: 'error');
      } else {
        apiConsumer.removeToken();
        return response['message'];
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<OnBoardingModel> getOnBoardingData() async {
    try {
      final response =
          await apiConsumer.get(url: "${EndPoints.baseUrl}onboard");
      OnBoardingModel result = OnBoardingModel.fromJson(response);
      if (response["onboards"] == null) {
        throw ServerException(message: 'error');
      } else {
        return result;
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<CounteryModel> getCounterySelect({bool isAll = false}) async {
    String url = isAll == true ? "countries" : "countries?show=1";
    try {
      final response = await apiConsumer.get(url: "${EndPoints.baseUrl}$url");
      CounteryModel result = CounteryModel.fromJson(response);
      if (response["countries"] == null) {
        throw ServerException(message: 'error');
      } else {
        return result;
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<GetDataAddPropertyModel> getDataAddProparty() async {
    try {
      final response =
          await apiConsumer.get(url: "${EndPoints.baseUrl}property/data");
      GetDataAddPropertyModel result =
          GetDataAddPropertyModel.fromJson(response);
      if (response == null) {
        throw ServerException(message: 'error');
      } else {
        return result;
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<SendOtpModel> sendOtpPhone(
      {required SendOtpParams sendOtpParams, required String token}) async {
    try {
      Map<String, dynamic> _body = {
        "mobile_country_id": sendOtpParams.mobileConteryId,
        "mobile_number": sendOtpParams.mobileNumber,
      };
      if (sendOtpParams.validUniq != null) {
        _body.addAll({"validate_uniqueness": sendOtpParams.validUniq});
      }
      final response = await apiConsumer.post(
          url: "${EndPoints.baseUrl}mn/send_otp", body: _body, token: token);

      SendOtpModel result = SendOtpModel.fromJson(response);
      if (response == null) {
        throw ServerException(message: 'error');
      } else {
        return result;
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<RegisterModel> completeRegister(
      CompleteRegisterParams registerParams, String token) async {
    try {
      final response = await apiConsumer.post(
          url: "${EndPoints.baseUrl}complete_register",
          body: {
            "name": registerParams.name.trim(),
            "account_type": registerParams.accountType.trim(),
            "agency_name": registerParams.agencyName == null
                ? null
                : registerParams.agencyName!.trim(),
            "lang": registerParams.lang,
            "account_mode": registerParams.accountMode.trim(),
            // "name": registerParams.name.trim(),
          },
          token: token);
      log(response.runtimeType.toString());
      RegisterModel? result;
      if (response.runtimeType != String) {
        result = RegisterModel.fromJson(response);
        return result;
      } else {
        // log(response.toString());
        //res = response;
        throw ServerException(message: response.toString());
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<String> updateLocation(
      {required UpdateLocationParams updateLocationParams,
      required String token}) async {
    try {
      final response = await apiConsumer.post(
          url: "${EndPoints.baseUrl}profile/location",
          body: {
            "_method": "PUT",
            "country": updateLocationParams.countery.trim(),
            "state": updateLocationParams.state.trim(),
            "city": updateLocationParams.city,
            "latitude": updateLocationParams.lat.trim(),
            "longitude": updateLocationParams.lang.trim(),
          },
          token: token);
      log(response.runtimeType.toString());

      if (response.runtimeType != String) {
        return response["message"];
      } else {
        // log(response.toString());
        //res = response;
        throw ServerException(message: response.toString());
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }
}
