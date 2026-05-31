import 'package:organ_link/apis/managers/user_manager/user_api_manager.dart';
import 'package:organ_link/features/user_flow/case_follow_up/bloc/case_follow_up_bloc.dart';
import 'package:organ_link/features/user_flow/case_follow_up/models/case_follow_up_ui_model.dart';
import 'package:organ_link/preferences/preferences_manager.dart';

abstract class BaseCaseFollowUpRepository {
  Future<CaseFollowUpState> geCaseFollowUpData();
}

class CaseFollowUpRepository implements BaseCaseFollowUpRepository {
  final UserApiManager userHomeApiManager;
  final PreferencesManager preferencesManager;

  CaseFollowUpRepository({
    required this.userHomeApiManager,
    required this.preferencesManager,
  });
  @override
  Future<CaseFollowUpState> geCaseFollowUpData() async {
    late CaseFollowUpState caseFollowUpState;
    final int? id = await preferencesManager.getId();
    await userHomeApiManager.caseFollowUpApi(
      id!,
      (response) {
        final model = CaseFollowUpUiModel.formApiModel(response);
        caseFollowUpState = CaseFollowUpDataLoadedSuccessfullyState(
          caseFollowUpUiModel: model,
        );
      },
      (error) {
        caseFollowUpState = CaseFollowUpErrorState(
          errorMessage: error.message,
          codeError: error.code,
        );
      },
    );
    return caseFollowUpState;
  }
}
