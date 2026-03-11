import 'package:organ_link/apis/managers/hospital_manager/hospital_api_manager.dart';
import 'package:organ_link/features/hospital_flow/view_patient_or_donor/bloc/view_patient_or_donor_bloc.dart';
import 'package:organ_link/features/hospital_flow/view_patient_or_donor/models/patient_or_donor_ui_model.dart';
import 'package:organ_link/preferences/preferences_manager.dart';

abstract class BaseViewPatientOrDonorRepository {
  Future<ViewPatientOrDonorState> getViewPatientData();
  Future<ViewPatientOrDonorState> getViewDonorData();
}

class ViewPatientOrDonorRepository implements BaseViewPatientOrDonorRepository {
  final HospitalApiManager hospitalApiManager;
  final PreferencesManager preferencesManager;

  ViewPatientOrDonorRepository({
    required this.hospitalApiManager,
    required this.preferencesManager,
  });
  @override
  Future<ViewPatientOrDonorState> getViewPatientData() async {
    late ViewPatientOrDonorState viewPatientOrDonorState;
    final int? id = await preferencesManager.getId();
    await hospitalApiManager.getPatientsOrDonorsListApi(
      id!,
      (response) {
        final model = response.patientList
            .map((x) => PatientOrDonorUiModel.fromApiModel(x))
            .toList();
        viewPatientOrDonorState = ViewPatientOrDonorDataLoadedSuccessfullyState(
          donorOrPatientList: model,
        );
      },
      (error) {
        viewPatientOrDonorState = ViewPatientOrDonorErrorState(
          errorMessage: error.message,
          codeError: error.code,
        );
      },
    );
    return viewPatientOrDonorState;
  }

  @override
  Future<ViewPatientOrDonorState> getViewDonorData() async {
    late ViewPatientOrDonorState viewPatientOrDonorState;
    final int? id = await preferencesManager.getId();
    await hospitalApiManager.getPatientsOrDonorsListApi(
      id!,
      (response) {
        final model = response.donorList
            .map((x) => PatientOrDonorUiModel.fromApiModel(x))
            .toList();
        viewPatientOrDonorState = ViewPatientOrDonorDataLoadedSuccessfullyState(
          donorOrPatientList: model,
        );
      },
      (error) {
        viewPatientOrDonorState = ViewPatientOrDonorErrorState(
          errorMessage: error.message,
          codeError: error.code,
        );
      },
    );
    // await hospitalApiManager.getHospitalDataApi(
    //   id!,
    //   (response) {
    //     final model = response.donorList
    //         .map((x) => PatientOrDonorUiModel.fromApiModel(x))
    //         .toList();
    //     viewPatientOrDonorState = ViewPatientOrDonorDataLoadedSuccessfullyState(
    //       donorOrPatientList: model,
    //     );
    //   },
    //   (error) {
    //     viewPatientOrDonorState = ViewPatientOrDonorErrorState(
    //       errorMessage: error.message,
    //       codeError: error.code,
    //     );
    //   },
    // );

    return viewPatientOrDonorState;
  }
}
