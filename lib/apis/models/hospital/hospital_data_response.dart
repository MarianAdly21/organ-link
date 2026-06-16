class HospitalDataResponse {
  final String hospitalName;
  final String hospitalCity;
  final String licenseNumber;
  final String phone;
  final String email;
  final int totalMatches;
  final int totalSurgeries;
  final int patientsCount;
  final int donorsCount;

  HospitalDataResponse({
    required this.hospitalName,
    required this.hospitalCity,
    required this.totalMatches,
    required this.totalSurgeries,
    required this.patientsCount,
    required this.donorsCount,
    required this.licenseNumber,
    required this.phone,
    required this.email,
  });
  factory HospitalDataResponse.formJson(Map<String, dynamic> json) {
    return HospitalDataResponse(
      hospitalName: json["name"],
      hospitalCity: json["location"],
      totalMatches: json["total_matches"],
      totalSurgeries: json["total_surgeries"],
      patientsCount: json["patients_count"],
      donorsCount: json["donors_count"],
      licenseNumber: json["license_number"],
      phone: json["phone"],
      email: json["email"],
      );
  }
}
