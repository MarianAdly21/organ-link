part of 'medical_details_bloc.dart';

sealed class MedicalDetailsState extends Equatable {
  const MedicalDetailsState();

  @override
  List<Object> get props => [];
}

final class MedicalDetailsInitial extends MedicalDetailsState {}

class MedicalDetailsErrorState extends MedicalDetailsState {
  final String errorMessage;
  final int codeError;

  const MedicalDetailsErrorState({
    required this.errorMessage,
    required this.codeError,
  });
}

class MedicalDetailsLoadingState extends MedicalDetailsState {}

class MedicalDetailsDataLoadedSuccessfullyState extends MedicalDetailsState {
  final MedicalDetailsUiModel medicalDetailsUiModel;

  const MedicalDetailsDataLoadedSuccessfullyState({
    required this.medicalDetailsUiModel,
  });
}
