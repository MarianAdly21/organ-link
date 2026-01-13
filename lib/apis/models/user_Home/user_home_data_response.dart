class UserHomeDataResponse {
    final String name;
  final String type;
  final String identificationNumber;
  final String currentState;

  UserHomeDataResponse({required this.name, required this.type, required this.identificationNumber, required this.currentState});
  factory UserHomeDataResponse.formJson(Map<String, dynamic> json){
    return UserHomeDataResponse(name:  json[""], type:  json[""], identificationNumber: json[""], currentState:  json[""]);
  }
}
