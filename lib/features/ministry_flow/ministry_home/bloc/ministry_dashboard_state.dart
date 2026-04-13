part of 'ministry_dashboard_bloc.dart';

sealed class MinistryDashboardState extends Equatable {
  const MinistryDashboardState();

  @override
  List<Object> get props => [];
}

final class MinistryDashboardInitial extends MinistryDashboardState {}

class MinistryDashboardErrorState extends MinistryDashboardState {
  final String errorMessage;
  final int codeError;

  const MinistryDashboardErrorState({
    required this.errorMessage,
    required this.codeError,
  });
}

class MinistryDashboardLoadingState extends MinistryDashboardState {}

class MinistryDashboardDataLoadedSuccessfullyState
    extends MinistryDashboardState {
      final MinistryDashboardUiModel ministryDashboardUiModel;

const  MinistryDashboardDataLoadedSuccessfullyState({required this.ministryDashboardUiModel});
    }

class NavigationToNotificationScreenState extends MinistryDashboardState {
  @override
  List<Object> get props => [identityHashCode(this)];
}

class NavigationToSettingScreenState extends MinistryDashboardState {
  @override
  List<Object> get props => [identityHashCode(this)];
}

class NavigationToHospitalsScreenState extends MinistryDashboardState {
  @override
  List<Object> get props => [identityHashCode(this)];
}
