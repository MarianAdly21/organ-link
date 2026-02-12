import 'package:organ_link/apis/managers/user_manager/medical_details_api_manager.dart';
import 'package:organ_link/features/user_flow/medical_details/bloc/medical_details_bloc.dart';
import 'package:organ_link/features/user_flow/medical_details/models/medical_details_ui_model.dart';
import 'package:organ_link/preferences/preferences_manager.dart';

abstract class BaseMedicalDetailsRepository {
  Future<MedicalDetailsState> getMedicalDetailsData();
}

class MedicalDetailsRepository implements BaseMedicalDetailsRepository {
  final MedicalDetailsApiManager medicalDetailsApiManager;
  final PreferencesManager preferencesManager;

  MedicalDetailsRepository({
    required this.medicalDetailsApiManager,
    required this.preferencesManager,
  });

  @override
  Future<MedicalDetailsState> getMedicalDetailsData() async {
    late MedicalDetailsState medicalDetailsState;
    final int? id = await preferencesManager.getId();
    await medicalDetailsApiManager.medicalDetailsDataApi(
      id!,
      (response) {
        final model = MedicalDetailsUiModel.fromApiModel(response);
        medicalDetailsState = MedicalDetailsDataLoadedSuccessfullyState(
          medicalDetailsUiModel: model,
        );
      },
      (error) {
        medicalDetailsState = MedicalDetailsErrorState(
          errorMessage: error.message,
          codeError: error.code,
        );
      },
    );

    return medicalDetailsState;
  }
}
