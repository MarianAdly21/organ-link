part of 'ministry_notification_bloc.dart';

sealed class MinistryNotificationEvent extends Equatable {
  const MinistryNotificationEvent();

  @override
  List<Object> get props => [];
}

class GetMinistryNotificationDataEvent extends MinistryNotificationEvent {}

class NavToNotificationDetailsScreenEvent extends MinistryNotificationEvent {
  final int id;

  const NavToNotificationDetailsScreenEvent({required this.id});
}
