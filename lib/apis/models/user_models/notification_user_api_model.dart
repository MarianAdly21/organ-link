class NotificationUserApiModel {
  final String messageTitle;
  final String messageContent;
  final String notificationType;
  final DateTime date;


  NotificationUserApiModel({
    required this.messageTitle,
    required this.messageContent,
    required this.notificationType,
    required this.date,
  });

  factory NotificationUserApiModel.formJson(Map<String, dynamic> json) {
    return NotificationUserApiModel(
      messageTitle: json["message_title"],
      messageContent: json["message"],
      date: DateTime.parse(json["created_at"]) ,
      notificationType: json["alert_type"]
    );
  }
}
