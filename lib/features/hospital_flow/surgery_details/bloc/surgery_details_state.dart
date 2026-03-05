part of 'surgery_details_bloc.dart';

sealed class SurgeryDetailsState extends Equatable {
  const SurgeryDetailsState();
  
  @override
  List<Object> get props => [];
}

final class SurgeryDetailsInitial extends SurgeryDetailsState {}
class SurgeryDetailsErrorState extends SurgeryDetailsState {
  final String errorMessage;
  final int codeError;

  const SurgeryDetailsErrorState({
    required this.errorMessage,
    required this.codeError,
  });
}

class SurgeryDetailsLoadingState extends SurgeryDetailsState {}

class SurgeryDetailsDataLoadedSuccessfullyState extends SurgeryDetailsState {
  final SurgeryDetailsUiModel surgeryDetailsUiModel;

  const SurgeryDetailsDataLoadedSuccessfullyState({required this.surgeryDetailsUiModel});
}

class NavToPatientOrDonorDetailsScreenState extends SurgeryDetailsState {
  final int id;
  final NavType type;
  const NavToPatientOrDonorDetailsScreenState({required this.id, required this.type});

  @override
  List<Object> get props => [identityHashCode(this)];
}