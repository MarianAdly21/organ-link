import 'package:organ_link/apis/managers/hospital_manager/hospital_api_manager.dart';
import 'package:organ_link/features/hospital_flow/surgery_details/bloc/surgery_details_bloc.dart';
import 'package:organ_link/features/hospital_flow/surgery_details/models/surgery_details_ui_model.dart';

abstract class BaseSurgeryDetailsRepository {
  Future<SurgeryDetailsState> getSurgerDetails(int id);
}

class SurgeryDetailsRepository implements BaseSurgeryDetailsRepository {
  final HospitalApiManager hospitalApiManager;

  SurgeryDetailsRepository({required this.hospitalApiManager});
  @override
  Future<SurgeryDetailsState> getSurgerDetails(int id) async {
    late SurgeryDetailsState surgeryDetailsState;
    await hospitalApiManager.getSurgeryDetailsDataApi(
      id,
      (response) {
        final model = SurgeryDetailsUiModel.fromApiModel(response);
        surgeryDetailsState = SurgeryDetailsDataLoadedSuccessfullyState(
          surgeryDetailsUiModel: model,
        );
      },
      (error) {
        surgeryDetailsState = SurgeryDetailsErrorState(
          errorMessage: error.message,
          codeError: error.code,
        );
      },
    );
    return surgeryDetailsState;
  }
}
