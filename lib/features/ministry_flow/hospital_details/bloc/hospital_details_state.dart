part of 'hospital_details_bloc.dart';

sealed class HospitalDetailsState extends Equatable {
  const HospitalDetailsState();

  @override
  List<Object> get props => [];
}

final class HospitalDetailsInitial extends HospitalDetailsState {}

class HospitalDetailsErrorState extends HospitalDetailsState {
  final String errorMessage;
  final int codeError;

  const HospitalDetailsErrorState({
    required this.errorMessage,
    required this.codeError,
  });
}

class HospitalDetailsLoadingState extends HospitalDetailsState {}

class HospitalDetailsDataLoadedSuccessfullyState extends HospitalDetailsState {
  final MinistryHospitalDetailsUiModel ministryHospitalDetailsUiModel;

  const HospitalDetailsDataLoadedSuccessfullyState({
    required this.ministryHospitalDetailsUiModel,
  });
}
