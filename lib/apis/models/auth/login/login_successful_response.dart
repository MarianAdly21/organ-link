class LoginSuccessfulResponse {
  final int id;
  final String name;
  final String email;
  final bool isVerified;
  final String token;
  final String notifcationMessage;

  LoginSuccessfulResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.isVerified,
    required this.token,
    required this.notifcationMessage,
  });

  LoginSuccessfulResponse.formJson(Map<String, dynamic> json)
      : id = json["id"] as int,
        name = json["name"] as String,
        email = json["email"] as String,
        isVerified = json["is_verifed"] as bool,
        token = json["token"] as String,
        notifcationMessage = json["notifcation_message"] as String? ?? "";
}
