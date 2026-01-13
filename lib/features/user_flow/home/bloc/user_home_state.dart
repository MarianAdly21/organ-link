part of 'user_home_bloc.dart';

sealed class UserHomeState extends Equatable {
  const UserHomeState();
  
  @override
  List<Object> get props => [];
}

final class UserHomeInitial extends UserHomeState {}
 class UserHomeLoadingState extends UserHomeState {}
 class UserHomeErrorState extends UserHomeState {
  final String errorMessage;
  const UserHomeErrorState({required this.errorMessage});
 }

 class NavToMedicalDetailsScreenState extends UserHomeState{}
class NavToCaseFollowUpScreenState extends UserHomeState{}
class NavToHospitalInfoScreenState extends UserHomeState{}
class NavToNotificationScreenState extends UserHomeState{}
class NavToSettingScreenState extends UserHomeState{}

 class UserHomeDataLoadedSuccessfullyState extends UserHomeState {
  final UserHomeDataUiModel userHomeDataUiModel;

 const UserHomeDataLoadedSuccessfullyState({required this.userHomeDataUiModel});
 }
