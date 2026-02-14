part of 'hospital_dashboard_bloc.dart';



sealed class HospitalDashboardEvent extends Equatable {
  const HospitalDashboardEvent();

  @override
  List<Object> get props => [];
}

class GetHospitalDashboardDataEvent extends HospitalDashboardEvent {}

class NavToViewPatientOrDonorScreenEvent extends HospitalDashboardEvent {
  final NavType type;

  const NavToViewPatientOrDonorScreenEvent({required this.type});
}

class NavToSurgeriesScreenEvent extends HospitalDashboardEvent {}

class NavToMatchingScreenEvent extends HospitalDashboardEvent {}

class NavToHospitalNotificationScreenEvent extends HospitalDashboardEvent {}

class NavToHospitalSettingScreenEvent extends HospitalDashboardEvent {}
