import 'package:organ_link/apis/managers/ministry_manager/ministry_api_manager.dart';
import 'package:organ_link/features/ministry_flow/ministry_home/bloc/ministry_dashboard_bloc.dart';
import 'package:organ_link/features/ministry_flow/ministry_home/models/ministry_dashboard_ui_model.dart';

abstract class BaseMinistryDashboardRepository {
  Future<MinistryDashboardState> getMinistryDashboardData();
}

class MinistryDashboardRepository implements BaseMinistryDashboardRepository {
  final MinistryApiManager ministryApiManager;

  MinistryDashboardRepository({required this.ministryApiManager});
  @override
  Future<MinistryDashboardState> getMinistryDashboardData() async {
    late MinistryDashboardState ministryDashboardState;
    await ministryApiManager.getMinistryDashboardData(
      (response) {
        final model = MinistryDashboardUiModel.fromApiModel(response);
        ministryDashboardState = MinistryDashboardDataLoadedSuccessfullyState(
          ministryDashboardUiModel: model,
        );
      },
      (error) {
        ministryDashboardState = MinistryDashboardErrorState(
          errorMessage: error.message,
          codeError: error.code,
        );
      },
    );
    return ministryDashboardState;
  }
}
