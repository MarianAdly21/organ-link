part of 'user_home_bloc.dart';

sealed class UserHomeState extends Equatable {
  const UserHomeState();

   @override
  List<Object> get props => [identityHashCode(this)];
}

final class UserHomeInitial extends UserHomeState {}

class UserHomeLoadingState extends UserHomeState {}

class UserHomeErrorState extends UserHomeState {
  final String errorMessage;
  final int codeError;

  const UserHomeErrorState({required this.errorMessage, required this.codeError});
}

class NavToMedicalDetailsScreenState extends UserHomeState {
 
}

class NavToCaseFollowUpScreenState extends UserHomeState {}

class NavToHospitalInfoScreenState extends UserHomeState {}

class NavToNotificationScreenState extends UserHomeState {}

class NavToSettingScreenState extends UserHomeState {}

class UserHomeDataLoadedSuccessfullyState extends UserHomeState {
  final UserHomeDataUiModel userHomeDataUiModel;

  const UserHomeDataLoadedSuccessfullyState({
    required this.userHomeDataUiModel,
  });
}
