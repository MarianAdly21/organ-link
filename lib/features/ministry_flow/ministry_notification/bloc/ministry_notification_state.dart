part of 'ministry_notification_bloc.dart';

sealed class MinistryNotificationState extends Equatable {
  const MinistryNotificationState();

  @override
  List<Object> get props => [];
}

final class MinistryNotificationInitial extends MinistryNotificationState {}

class MinistryNotificationErrorState extends MinistryNotificationState {
  final String errorMessage;
  final int codeError;

  const MinistryNotificationErrorState({
    required this.errorMessage,
    required this.codeError,
  });
}

class MinistryNotificationLoadingState extends MinistryNotificationState {}

class MinistryNotificationDataLoadedSuccessfullyState
    extends MinistryNotificationState {
  final MinistryNotificationUiModel ministryNotificationUiModel;
  const MinistryNotificationDataLoadedSuccessfullyState({
    required this.ministryNotificationUiModel,
  });
}

class NavToNotificationDetailsScreenState extends MinistryNotificationState {
  final int id;
  const NavToNotificationDetailsScreenState({required this.id});

  @override
  List<Object> get props => [identityHashCode(this)];
}
