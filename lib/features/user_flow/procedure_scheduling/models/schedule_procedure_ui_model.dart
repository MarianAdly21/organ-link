import 'package:organ_link/apis/models/user_models/schedule_procedure_api_model.dart';

class ScheduleProcedureUiModel {
  final DateTime scheduledDate;
  final String scheduledTime;
  final int duration;
  final String operationRoom;
  final String doctorSpecialty;
  final String doctorName;
  final String hospitalName;

  ScheduleProcedureUiModel({
    required this.scheduledDate,
    required this.scheduledTime,
    required this.duration,
    required this.operationRoom,
    required this.doctorSpecialty,
    required this.doctorName,
    required this.hospitalName,
  });
  factory ScheduleProcedureUiModel.fromApiModel(ScheduleProcedureApiModel e) {
    return ScheduleProcedureUiModel(
      scheduledDate: e.scheduledDate,
      scheduledTime: e.scheduledTime,
      duration: e.duration,
      operationRoom: e.operationRoom,
      doctorSpecialty: e.doctorSpecialty,
      doctorName: e.doctorName,
      hospitalName: e.hospitalName,
    );
  }
}
