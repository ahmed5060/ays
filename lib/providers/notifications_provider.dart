import 'package:courses_app/core/endpoints/end_points.dart';
import 'package:flutter/material.dart';
import '../core/helper/api_helper.dart';
import '../models/notification_model.dart';

class NotificationsProvider extends ChangeNotifier {
  List<NotificationModel> notifications = [];
  bool getNotificationsLoading = false;

  Future<void> getNotifications() async {
    getNotificationsLoading = true;
    notifyListeners();

    final response = await APIHelper.apiCall(
      type: APICallType.get,
      url: EndPoints.getNotifications,
    );

    if (response.success) {
      if (response.data != null && response.data['data'] != null) {
        notifications = [];
        response.data['data'].forEach((item) {
          notifications.add(
            NotificationModel.fromJson(
              item,
            ),
          );
        });
        notifyListeners();
      }
    }

    getNotificationsLoading = false;
    notifyListeners();
  }

}
