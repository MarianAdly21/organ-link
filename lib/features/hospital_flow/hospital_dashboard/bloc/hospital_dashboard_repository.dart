import 'package:organ_link/apis/managers/hospital_manager/hospital_api_manager.dart';
import 'package:organ_link/features/hospital_flow/hospital_dashboard/bloc/hospital_dashboard_bloc.dart';
import 'package:organ_link/features/hospital_flow/hospital_dashboard/models/hospital_dashboard_ui_model.dart';
import 'package:organ_link/preferences/preferences_manager.dart';

abstract class BaseHospitalDashboardRepository {
  Future<HospitalDashboardState> getHospitalDashboardData();
}

class HospitalDashboardRepository implements BaseHospitalDashboardRepository {
  final HospitalApiManager hospitalApiManager;
  final PreferencesManager preferencesManager;

  HospitalDashboardRepository({
    required this.hospitalApiManager,
    required this.preferencesManager,
  });
  @override
  Future<HospitalDashboardState> getHospitalDashboardData() async {
    late HospitalDashboardState hospitalDashboardState;
     final int? id = await preferencesManager.getId();
    await hospitalApiManager.getHospitalDataApi(
     id!,
      (response) {
        final model = HospitalDashboardUiModel.fromApiModel(response);
        hospitalDashboardState = HospitalDashboardDataLoadedSuccessfullyState(
          hospitalDashboardUiModel: model,
        );
      },
      (error) {
        hospitalDashboardState = HospitalDashboardErrorState(
          errorMessage: error.message,
          codeError: error.code,
        );
      },
    );
    return hospitalDashboardState;
  }
}
