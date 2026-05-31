class CaseFollowUpApiModel {
  final bool isSchedule;

  CaseFollowUpApiModel({required this.isSchedule});
  factory CaseFollowUpApiModel.formJson(Map<String, dynamic> json) {
    return CaseFollowUpApiModel(isSchedule: (json["surgeries"]==null) ? false : true);
  }
}
 