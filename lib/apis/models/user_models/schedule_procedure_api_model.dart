class ScheduleProcedureApiModel {
  final DateTime scheduledDate;
  final String scheduledTime;
  final int duration;
  final String operationRoom;
  final String doctorSpecialty;
  final String doctorName;
  final String hospitalName;

  ScheduleProcedureApiModel({
    required this.scheduledDate,
    required this.scheduledTime,
    required this.duration,
    required this.operationRoom,
    required this.doctorSpecialty,
    required this.doctorName,
    required this.hospitalName,
  });

  factory ScheduleProcedureApiModel.formJson(Map<String, dynamic> json) {
    return ScheduleProcedureApiModel(
      scheduledDate: DateTime.parse(json["surgeries"]["scheduled_date"]),
      scheduledTime: json["surgeries"]["scheduled_time"],
      duration: json["surgeries"]["duration"],
      operationRoom: json["surgeries"]["operation_room"],
      doctorSpecialty: json["surgeries"]["doctor_detail"]["specialty"],
      doctorName: json["surgeries"]["doctor_detail"]["name"],
      hospitalName: json["surgeries"]["hospital_detail"]["name"],
    );
  }
}
