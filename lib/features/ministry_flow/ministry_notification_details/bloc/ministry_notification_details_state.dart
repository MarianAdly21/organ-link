part of 'ministry_notification_details_bloc.dart';

sealed class MinistryNotificationDetailsState extends Equatable {
  const MinistryNotificationDetailsState();

  @override
  List<Object> get props => [];
}

final class MinistryNotificationDetailsInitial
    extends MinistryNotificationDetailsState {}

class MinistryNotificationDetailsErrorState
    extends MinistryNotificationDetailsState {
  final String errorMessage;
  final int codeError;

  const MinistryNotificationDetailsErrorState({
    required this.errorMessage,
    required this.codeError,
  });
}

class MinistryNotificationDetailsLoadingState
    extends MinistryNotificationDetailsState {}

class MinistryNotificationDetailsDataLoadedSuccessfullyState
    extends MinistryNotificationDetailsState {
  final MinistryNotificationDetailsUiModel ministryNotificationDetailsUiModel;
  const MinistryNotificationDetailsDataLoadedSuccessfullyState({
    required this.ministryNotificationDetailsUiModel,
  });
}
