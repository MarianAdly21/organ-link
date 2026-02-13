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
      scheduledDate: DateTime.parse(json["scheduled_date"]),
      scheduledTime: json["scheduled_time"],
      duration: json["duration"],
      operationRoom: json["operation_room"],
      doctorSpecialty: json["doctor_detail"]["specialty"],
      doctorName: json["doctor_detail"]["name"],
      hospitalName: json["hospital_detail"]["name"],
    );
  }
}
