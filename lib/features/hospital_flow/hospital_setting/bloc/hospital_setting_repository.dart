import 'package:organ_link/apis/managers/hospital_manager/hospital_api_manager.dart';
import 'package:organ_link/features/hospital_flow/hospital_setting/bloc/hospital_setting_bloc.dart';
import 'package:organ_link/features/hospital_flow/hospital_setting/model/hospital_information_setting_ui_model.dart';
import 'package:organ_link/preferences/preferences_manager.dart';

abstract class BaseHospitalSettingRepository {
  Future<HospitalSettingState> getHospitalInformationData();
}

class HospitalSettingRepository implements BaseHospitalSettingRepository {
  final HospitalApiManager hospitalApiManager;
  final PreferencesManager preferencesManager;

  HospitalSettingRepository({
    required this.hospitalApiManager,
    required this.preferencesManager,
  });
  @override
  Future<HospitalSettingState> getHospitalInformationData() async {
    late HospitalSettingState hospitalSettingState;
    final int? id = await preferencesManager.getId();
    await hospitalApiManager.getHospitalDataApi(
      id!,
      (response) {
        final model = HospitalInformationSettingUiModel.fromApiModel(response);
        hospitalSettingState = HospitalSettingLoadedSuccessfullyState(
          hospitalInformationSettingUiModel: model,
        );
      },
      (error) {
        hospitalSettingState = HospitalSettingErrorState(
          errorMessage: error.message,
          codeError: error.code,
        );
      },
    );
    return hospitalSettingState;
  }
}
