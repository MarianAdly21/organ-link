part of 'user_home_bloc.dart';

sealed class UserHomeEvent extends Equatable {
  const UserHomeEvent();

  @override
  List<Object> get props => [];
}

class GetHomeUserDateEvent extends UserHomeEvent {}

class NavToMedicalDetailsScreenEvent extends UserHomeEvent {}

class NavToCaseFollowUpScreenEvent extends UserHomeEvent {}

class NavToHospitalInfoScreenEvent extends UserHomeEvent {}

class NavToNotificationScreenEvent extends UserHomeEvent {}

class NavToSettingScreenEvent extends UserHomeEvent {}
