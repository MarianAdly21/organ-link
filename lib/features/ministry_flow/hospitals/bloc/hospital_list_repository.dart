import 'package:organ_link/apis/managers/ministry_manager/ministry_api_manager.dart';
import 'package:organ_link/features/ministry_flow/hospitals/bloc/hospital_list_bloc.dart';
import 'package:organ_link/features/ministry_flow/hospitals/models/hospitals_list_ui_model.dart';

abstract class BaseHospitalListRepository {
  Future<HospitalListState> getHospitalsList();
}

class HospitalListRepository implements BaseHospitalListRepository {
final MinistryApiManager ministryApiManager;
  HospitalListRepository({required this.ministryApiManager});
  @override
  Future<HospitalListState> getHospitalsList()async {
   late HospitalListState hospitalListState;
    await ministryApiManager.getHospitalsListData(
      (response) {
        final model = HospitalsListUiModel.fromApiModel(response);
        hospitalListState = HospitalListDataLoadedSuccessfullyState(
          hospitals: model,
        );
      },
      (error) {
        hospitalListState = HospitalListErrorState(
          errorMessage: error.message,
          codeError: error.code,
        );
      },
    );
    return hospitalListState;
  }
}
