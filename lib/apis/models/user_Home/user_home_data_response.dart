class UserHomeDataResponse {
  final String fullName;
  final String type;
  final String identificationNumber;
  final String currentState;

  UserHomeDataResponse({
    required this.fullName,
    required this.type,
    required this.identificationNumber,
    required this.currentState,
  });
  factory UserHomeDataResponse.formJson(Map<String, dynamic> json) {
    return UserHomeDataResponse(
      fullName: json["full_name"] as String,
      type: json["role"] as String,
      identificationNumber: json["medical_record_number"] as String,
      currentState: json["status"] as String,
    );
  }
}
