import 'package:organ_link/apis/managers/hospital_manager/hospital_api_manager.dart';
import 'package:organ_link/features/hospital_flow/patient_or_donor_details/bloc/patient_or_donor_details_bloc.dart';
import 'package:organ_link/features/hospital_flow/patient_or_donor_details/models/patient_or_donor_details_ui_model.dart';

abstract class BasePatientOrDonorDetailsRepository {
  Future<PatientOrDonorDetailsState> getPatientOrDonorDetailsData(int id);
}

class PatientOrDonorDetailsRepository
    implements BasePatientOrDonorDetailsRepository {
  final HospitalApiManager hospitalApiManager;

  PatientOrDonorDetailsRepository({required this.hospitalApiManager});

  @override
  Future<PatientOrDonorDetailsState> getPatientOrDonorDetailsData(
    int id,
  ) async {
    late PatientOrDonorDetailsState patientOrDonorDetailsState;
    await hospitalApiManager.getPatientOrDonorDetailsDataApi(
      id,
      (response) {
        final model = PatientOrDonorDetailsUiModel.fromApiModel(response);
        patientOrDonorDetailsState =
            PatientOrDonorDetailsDataLoadedSuccessfullyState(
              patientOrDonorDetailsUiModel: model,
            );
      },
      (error) {
        patientOrDonorDetailsState = PatientOrDonorDetailsErrorState(
          errorMessage: error.message,
          codeError: error.code,
        );
      },
    );
    return patientOrDonorDetailsState;
  }
}
