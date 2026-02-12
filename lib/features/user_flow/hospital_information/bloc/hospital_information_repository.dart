import 'package:organ_link/apis/managers/user_manager/user_api_manager.dart';
import 'package:organ_link/features/user_flow/hospital_information/bloc/hospital_information_bloc.dart';
import 'package:organ_link/features/user_flow/hospital_information/models/hospital_information_ui_model.dart';
import 'package:organ_link/preferences/preferences_manager.dart';

abstract class BaseHospitalInformationRepository {
  Future<HospitalInformationState> getHospitalInformationDetailsData();
}

class HospitalInformationRepository
    implements BaseHospitalInformationRepository {
  final PreferencesManager preferencesManager;
  final UserApiManager userApiManager;

  HospitalInformationRepository({
    required this.preferencesManager,
    required this.userApiManager,
  });
  @override
  Future<HospitalInformationState> getHospitalInformationDetailsData() async {
    late HospitalInformationState hospitalInformationState;
    final int? id = await preferencesManager.getId();
    await userApiManager.getUserDataApi(
      id!,
      (response) {
        final model = HospitalInformationUiModel.fromApiModel(response);
        hospitalInformationState =
            HospitalInformationDataLoadedSuccessfullyState(
              hospitalInformationUiModel: model,
            );
      },
      (error) {
        hospitalInformationState = HospitalInformationErrorState(
          errorMessage: error.message,
          codeError: error.code,
        );
      },
    );
    return hospitalInformationState;
  }
}
