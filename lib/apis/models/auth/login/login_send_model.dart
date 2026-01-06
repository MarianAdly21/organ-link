class LoginSendModelApi {
  final String identificationNumber;
  final String password;

  LoginSendModelApi({required this.identificationNumber,required this.password});

  Map toMap() {
    return{
      "identificationNumber": identificationNumber,
      "password": password,
    };
  }
}
