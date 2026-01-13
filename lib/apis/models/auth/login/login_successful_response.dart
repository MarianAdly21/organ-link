class LoginSuccessfulResponse {
  final int id;

  LoginSuccessfulResponse({
    required this.id,

  });

  LoginSuccessfulResponse.formJson(Map<String, dynamic> json)
      : id = json["id"] as int;

 }
