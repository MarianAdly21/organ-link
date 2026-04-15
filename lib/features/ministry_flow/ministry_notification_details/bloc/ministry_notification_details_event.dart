part of 'ministry_notification_details_bloc.dart';

sealed class MinistryNotificationDetailsEvent extends Equatable {
  const MinistryNotificationDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetMinistryNotificationDetailsDataEvent
    extends MinistryNotificationDetailsEvent {
  final int id;

  const GetMinistryNotificationDetailsDataEvent({required this.id});
}
