part of 'view_patient_or_donor_bloc.dart';

sealed class ViewPatientOrDonorState extends Equatable {
  const ViewPatientOrDonorState();

  @override
  List<Object> get props => [];
}

final class ViewPatientOrDonorInitial extends ViewPatientOrDonorState {}

class ViewPatientOrDonorErrorState extends ViewPatientOrDonorState {
  final String errorMessage;
  final int codeError;

  const ViewPatientOrDonorErrorState({
    required this.errorMessage,
    required this.codeError,
  });
}

class ViewPatientOrDonorLoadingState extends ViewPatientOrDonorState {}

class ViewPatientOrDonorDataLoadedSuccessfullyState
    extends ViewPatientOrDonorState {
  final List<PatientOrDonorUiModel> donorOrPatientList;

  const ViewPatientOrDonorDataLoadedSuccessfullyState({
    required this.donorOrPatientList,
  });
}

class NavToDetailsScreenState extends ViewPatientOrDonorState {
  @override
  List<Object> get props => [identityHashCode(this)];
  final int id;

  const NavToDetailsScreenState({required this.id});
}
