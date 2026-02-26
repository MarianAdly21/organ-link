import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:organ_link/features/hospital_flow/patient_or_donor_details/bloc/patient_or_donor_details_repository.dart';
import 'package:organ_link/features/hospital_flow/patient_or_donor_details/models/patient_or_donor_details_ui_model.dart';

part 'patient_or_donor_details_event.dart';
part 'patient_or_donor_details_state.dart';

class PatientOrDonorDetailsBloc
    extends Bloc<PatientOrDonorDetailsEvent, PatientOrDonorDetailsState> {
  final PatientOrDonorDetailsRepository patientOrDonorDetailsRepository;
  PatientOrDonorDetailsBloc(this.patientOrDonorDetailsRepository)
    : super(PatientOrDonorDetailsInitial()) {
    on<GetPatientOrDonorDetailsDataEvent>(_getPatientOrDonorData);
    on<AddNewReportClickEvent>(_addNewReportClickEvent);
  }

  FutureOr<void> _getPatientOrDonorData(
    GetPatientOrDonorDetailsDataEvent event,
    Emitter<PatientOrDonorDetailsState> emit,
  ) async {
    emit(PatientOrDonorDetailsLoadingState());
    emit(
      await patientOrDonorDetailsRepository.getPatientOrDonorDetailsData(
        event.id,
      ),
    );
  }

  FutureOr<void> _addNewReportClickEvent(
    AddNewReportClickEvent event,
    Emitter<PatientOrDonorDetailsState> emit,
  ) async {
    emit(PatientOrDonorDetailsLoadingState());
  }
}
