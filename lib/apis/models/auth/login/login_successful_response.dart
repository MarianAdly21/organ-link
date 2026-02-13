class LoginSuccessfulResponse {
  final int id;
  // final String nationalId;
  // final String firstName;
  // final String lastName;
  final String role;
  final String token;
  final String message;

  LoginSuccessfulResponse({
    required this.id,
    // required this.nationalId,
    // required this.firstName,
    // required this.lastName,
    required this.role,
    required this.token,
    required this.message,
  });

  factory LoginSuccessfulResponse.fromJson(Map<String, dynamic> json) {
    return LoginSuccessfulResponse(
      id: json["id"],
     // nationalId: json["national_id"],
      // firstName: json["first_name"],
      // lastName: json["last_name"],
      role: json["role"],
      token: json["token"],
      message: json["Message"],
    );
  }
}
