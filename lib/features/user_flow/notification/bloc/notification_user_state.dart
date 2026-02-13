part of 'notification_user_bloc.dart';

sealed class NotificationUserState extends Equatable {
  const NotificationUserState();

  @override
  List<Object> get props => [];
}

final class NotificationUserInitial extends NotificationUserState {}

class NotificationUserErrorState extends NotificationUserState {
  final String errorMessage;
  final int codeError;

  const NotificationUserErrorState({
    required this.errorMessage,
    required this.codeError,
  });
}

class NotificationUserLoadingState extends NotificationUserState {}

class NotificationUserDataLoadedSuccessfullyState
    extends NotificationUserState {
  final List<NotificationUserUiModel> notificationUserUiModel;

  const NotificationUserDataLoadedSuccessfullyState({
    required this.notificationUserUiModel,
  });
}
