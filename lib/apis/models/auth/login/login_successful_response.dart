class LoginSuccessfulResponse {
  final int id;
  final String message;
  final String type;

  LoginSuccessfulResponse({
    required this.id,
    required this.message,
    required this.type,
  });

  factory LoginSuccessfulResponse.fromJson(Map<String, dynamic> json) {
    return LoginSuccessfulResponse(
      id: json["id"],
      message: json["message"],
      type: json["type"],
    );
  }
}
