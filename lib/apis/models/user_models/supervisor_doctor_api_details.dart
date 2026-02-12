class SupervisorDoctorApiDetails {
  final String doctorName;
  final String specialty;
  final String phone;

  SupervisorDoctorApiDetails({
    required this.doctorName,
    required this.specialty,
    required this.phone,
  });
  factory SupervisorDoctorApiDetails.formJson(Map<String, dynamic> json) {
    return SupervisorDoctorApiDetails(
      doctorName: json["name"],
      specialty: json["specialty"],
      phone: json["phone"],
    );
  }
}
