class LoginSuccessfulResponse {
  final int id;
  final String message;
  final String type;
  final String token;

  LoginSuccessfulResponse({
    required this.id,
    required this.message,
    required this.type,
    required this.token,
  });

  factory LoginSuccessfulResponse.fromJson(Map<String, dynamic> json) {
    return LoginSuccessfulResponse(
      id: json["id"],
      message: json["message"],
      type: json["type"],
      token: json["token"],

    );
  }
}
