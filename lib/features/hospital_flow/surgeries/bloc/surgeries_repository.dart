import 'package:organ_link/apis/managers/hospital_manager/hospital_api_manager.dart';
import 'package:organ_link/features/hospital_flow/surgeries/bloc/surgeries_bloc.dart';
import 'package:organ_link/features/hospital_flow/surgeries/models/surgery_ui_model.dart';
import 'package:organ_link/preferences/preferences_manager.dart';

abstract class BaseSurgeriesRepository {
  Future<SurgeriesState> getSurgeriesList();
}

class SurgeriesRepository implements BaseSurgeriesRepository {
  final HospitalApiManager hospitalApiManager;
  final PreferencesManager preferencesManager;

  SurgeriesRepository({
    required this.hospitalApiManager,
    required this.preferencesManager,
  });
  @override
  Future<SurgeriesState> getSurgeriesList() async {
    late SurgeriesState surgeriesState;
    final int? id = await preferencesManager.getId();
    await hospitalApiManager.getHospitalDataApi(
      id!,
      (response) {
        final model = response.surgeriesList
            .map((x) => SurgeryUiModel.fromApiModel(x))
            .toList();
        surgeriesState = SurgeriesDataLoadedSuccessfullyState(
          surgeriesList: model,
        );
      },
      (error) {
        surgeriesState = SurgeriesErrorState(
          errorMessage: error.message,
          codeError: error.code,
        );
      },
    );
    return surgeriesState;
  }
}
