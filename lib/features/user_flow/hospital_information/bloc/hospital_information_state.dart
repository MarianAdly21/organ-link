part of 'hospital_information_bloc.dart';

sealed class HospitalInformationState extends Equatable {
  const HospitalInformationState();

  @override
  List<Object> get props => [];
}

final class HospitalInformationInitial extends HospitalInformationState {}

class HospitalInformationErrorState extends HospitalInformationState {
  final String errorMessage;
  final int codeError;

  const HospitalInformationErrorState({
    required this.errorMessage,
    required this.codeError,
  });
}

class HospitalInformationLoadingState extends HospitalInformationState {}

class HospitalInformationDataLoadedSuccessfullyState
    extends HospitalInformationState {
  final HospitalDetailsUiModel hospitalDetailsUiModel;

  const HospitalInformationDataLoadedSuccessfullyState({
    required this.hospitalDetailsUiModel,
  });
}
