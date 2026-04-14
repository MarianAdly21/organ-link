part of 'hospital_list_bloc.dart';

sealed class HospitalListState extends Equatable {
  const HospitalListState();

  @override
  List<Object> get props => [];
}

final class HospitalListInitial extends HospitalListState {}

class HospitalListErrorState extends HospitalListState {
  final String errorMessage;
  final int codeError;

  const HospitalListErrorState({
    required this.errorMessage,
    required this.codeError,
  });
}

class HospitalListLoadingState extends HospitalListState {}

class HospitalListDataLoadedSuccessfullyState extends HospitalListState {
  final HospitalsListUiModel hospitals;
  const HospitalListDataLoadedSuccessfullyState({required this.hospitals});
}

class NavToHospitalDetailsScreenState extends HospitalListState {
  final int id;
  const NavToHospitalDetailsScreenState({required this.id});

  @override
  List<Object> get props => [identityHashCode(this)];
}
