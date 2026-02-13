part of 'notification_user_bloc.dart';

sealed class NotificationUserEvent extends Equatable {
  const NotificationUserEvent();

  @override
  List<Object> get props => [];
}

class GetNotificationUserDataEvent extends NotificationUserEvent {}
