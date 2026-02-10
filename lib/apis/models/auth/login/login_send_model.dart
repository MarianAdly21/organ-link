import 'package:dio/dio.dart';

class LoginSendModelApi {
  final String identificationNumber;
  final String password;

  LoginSendModelApi({required this.identificationNumber, required this.password});


  FormData toMap() {
    return FormData.fromMap({
      "national_id": identificationNumber,
      "password": password,
    });
  }
}
