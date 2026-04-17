import 'package:organ_link/apis/managers/user_manager/user_api_manager.dart';
import 'package:organ_link/features/user_flow/procedure_scheduling/bloc/schedule_procedure_bloc.dart';
import 'package:organ_link/features/user_flow/procedure_scheduling/models/schedule_procedure_ui_model.dart';
import 'package:organ_link/preferences/preferences_manager.dart';

abstract class BaseScheduleProcedureRepository {
  Future<ScheduleProcedureState> getSurgeryData();
}

class ScheduleProcedureRepository implements BaseScheduleProcedureRepository {
  final UserApiManager userApiManager;
  final PreferencesManager preferencesManager;

  ScheduleProcedureRepository({
    required this.userApiManager,
    required this.preferencesManager,
  });

  @override
  Future<ScheduleProcedureState> getSurgeryData() async {
    late ScheduleProcedureState scheduleProcedureState;
    final int? id = await preferencesManager.getId();
    await userApiManager.getScheduleProcedureDataApi(
      id!,
      (response) {
        final model = ScheduleProcedureUiModel.fromApiModel(
          response,
        );
        scheduleProcedureState = ScheduleProcedureDataLoadedSuccessfullyState(
          scheduleProcedureUiModel: model,
        );
      },

      (error) {
        scheduleProcedureState = ScheduleProcedureErrorState(
          errorMessage: error.message,
          codeError: error.code,
        );
      },
    );
    return scheduleProcedureState;
  }
}
