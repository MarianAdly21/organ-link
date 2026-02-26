part of 'patient_or_donor_details_bloc.dart';

sealed class PatientOrDonorDetailsState extends Equatable {
  const PatientOrDonorDetailsState();

  @override
  List<Object> get props => [];
}

final class PatientOrDonorDetailsInitial extends PatientOrDonorDetailsState {}

class PatientOrDonorDetailsErrorState extends PatientOrDonorDetailsState {
  final String errorMessage;
  final int codeError;

  const PatientOrDonorDetailsErrorState({
    required this.errorMessage,
    required this.codeError,
  });
}

class PatientOrDonorDetailsLoadingState extends PatientOrDonorDetailsState {}

class PatientOrDonorDetailsDataLoadedSuccessfullyState
    extends PatientOrDonorDetailsState {
  final PatientOrDonorDetailsUiModel patientOrDonorDetailsUiModel;

  const PatientOrDonorDetailsDataLoadedSuccessfullyState({
    required this.patientOrDonorDetailsUiModel,
  });
}
