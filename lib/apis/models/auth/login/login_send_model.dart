import 'package:dio/dio.dart';

class LoginSendModelApi {
  final String identificationNumber;
  final String password;

  LoginSendModelApi(this.identificationNumber, this.password);

  FormData toMap() {
    return FormData.fromMap({
      "identification": identificationNumber,
      "password": password,
    });
  }
}
