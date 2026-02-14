part of 'hospital_dashboard_bloc.dart';

sealed class HospitalDashboardState extends Equatable {
  const HospitalDashboardState();

  @override
  List<Object> get props => [identityHashCode(this)];
}

final class HospitalDashboardInitial extends HospitalDashboardState {}

class HospitalDashboardErrorState extends HospitalDashboardState {
  final String errorMessage;
  final int codeError;

  const HospitalDashboardErrorState({
    required this.errorMessage,
    required this.codeError,
  });
}

class HospitalDashboardLoadingState extends HospitalDashboardState {}

class HospitalDashboardDataLoadedSuccessfullyState
    extends HospitalDashboardState {
  final HospitalDashboardUiModel hospitalDashboardUiModel;

  const HospitalDashboardDataLoadedSuccessfullyState({
    required this.hospitalDashboardUiModel,
  });
}

class NavToViewPatientOrDonorScreenState extends HospitalDashboardState {
  final NavType type;

  const NavToViewPatientOrDonorScreenState({required this.type});
}

class NavToSurgeriesScreenState extends HospitalDashboardState {}

class NavToMatchingScreenState extends HospitalDashboardState {}

class NavToHospitalNotificationScreenState extends HospitalDashboardState {}

class NavToHospitalSettingScreenState extends HospitalDashboardState {}
