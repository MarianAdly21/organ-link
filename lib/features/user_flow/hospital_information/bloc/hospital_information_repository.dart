import 'package:organ_link/apis/managers/user_manager/user_api_manager.dart';
import 'package:organ_link/features/user_flow/hospital_information/bloc/hospital_information_bloc.dart';
import 'package:organ_link/features/user_flow/hospital_information/models/hospital_details_ui_model.dart';
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
    await userApiManager.getHospitalDetailsDataApi(
      id!,
      (response) {
        final model = HospitalDetailsUiModel.fromApiModel(response);
        hospitalInformationState =
            HospitalInformationDataLoadedSuccessfullyState(
              hospitalDetailsUiModel: model,
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
