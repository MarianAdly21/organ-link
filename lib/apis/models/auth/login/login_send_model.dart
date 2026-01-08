import 'package:dio/dio.dart';

class LoginSendModelApi {
  final String email;
  final String password;

  LoginSendModelApi(this.email, this.password);

  FormData toMap() {
    return FormData.fromMap({
      "email": email,
      "password": password,
    });
  }
}
