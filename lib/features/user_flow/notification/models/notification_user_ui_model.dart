import 'package:organ_link/apis/models/user_models/notification_user_api_model.dart';

class NotificationUserUiModel {
  final String messageTitle;
  final String messageContent;
  final String notificationType;
  final DateTime date;

  NotificationUserUiModel({
    required this.messageTitle,
    required this.messageContent,
    required this.notificationType,
    required this.date,
  });
  factory NotificationUserUiModel.fromApiModel(NotificationUserApiModel e) {
    return NotificationUserUiModel(
      messageTitle: e.messageTitle,
      messageContent: e.messageContent,
      date: e.date,
      notificationType: e.notificationType
    );
  }
}
