import 'package:organ_link/apis/models/user_models/case_follow_up_api_model.dart';

class CaseFollowUpUiModel {
  final bool isSchedule;

  CaseFollowUpUiModel({required this.isSchedule});
  factory CaseFollowUpUiModel.formApiModel(CaseFollowUpApiModel e) {
    return CaseFollowUpUiModel(isSchedule: e.isSchedule);
  }
}
