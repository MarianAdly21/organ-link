part of 'ministry_dashboard_bloc.dart';

sealed class MinistryDashboardEvent extends Equatable {
  const MinistryDashboardEvent();

  @override
  List<Object> get props => [];
}

class GetMinistryDashboardDataEvent extends MinistryDashboardEvent {}

class NavigationToNotificationScreenEvent extends MinistryDashboardEvent {
  
}

class NavigationToSettingScreenEvent extends MinistryDashboardEvent {}

class NavigationToHospitalsScreenEvent extends MinistryDashboardEvent {}
