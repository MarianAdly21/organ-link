import 'package:organ_link/apis/managers/ministry_manager/ministry_api_manager.dart';
import 'package:organ_link/features/ministry_flow/hospital_details/bloc/hospital_details_bloc.dart';
import 'package:organ_link/features/ministry_flow/hospital_details/models/ministry_hospital_details_ui_model.dart';

abstract class BaseHospitalDetailsRepository {
  Future<HospitalDetailsState> getHospitalDetailsData(int id);
}

class HospitalDetailsRepository implements BaseHospitalDetailsRepository {
  final MinistryApiManager ministryApiManager;

  HospitalDetailsRepository({required this.ministryApiManager});

  @override
  Future<HospitalDetailsState> getHospitalDetailsData(int id) async {
    late HospitalDetailsState hospitalDetailsState;
    await ministryApiManager.getHospitalDetailsData(
      id,
      (response) {
        final model = MinistryHospitalDetailsUiModel.fromApiModel(response);
        hospitalDetailsState = HospitalDetailsDataLoadedSuccessfullyState(
          ministryHospitalDetailsUiModel: model,
        );
      },
      (error) {
        hospitalDetailsState = HospitalDetailsErrorState(
          errorMessage: error.message,
          codeError: error.code,
        );
      },
    );
    return hospitalDetailsState;
  }
}
