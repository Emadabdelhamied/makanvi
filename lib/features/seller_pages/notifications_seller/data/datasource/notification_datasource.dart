import 'dart:developer';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/util/api_basehelper.dart';
import '../../../../../core/util/end_points.dart';
import '../models/notification_model.dart';

abstract class NotificationDatasource {
  Future<NotificationModel> getNotification({
    required String token,
  });
  Future<String> deleteAllNotification({
    required String token,
  });
}

class NotificationDatasourceImpl implements NotificationDatasource {
  ApiBaseHelper apiConsumer;

  NotificationDatasourceImpl({required this.apiConsumer});

  @override
  Future<NotificationModel> getNotification({required String token}) async {
    String url = "notifications";

    log(url);
    try {
      final response = await apiConsumer.get(
        url: "${EndPoints.baseUrl}$url",
        token: token,
      );
      NotificationModel notificationModel =
          NotificationModel.fromJson(response);
      if (response == null) {
        throw ServerException(message: response["message"]);
      } else {
        return notificationModel;
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<String> deleteAllNotification({required String token}) async {
    String url = "notifications";

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
}
