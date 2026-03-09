part of 'hospital_notification_bloc.dart';

sealed class HospitalNotificationEvent extends Equatable {
  const HospitalNotificationEvent();

  @override
  List<Object> get props => [];
}

class GetHospitalNotificationDataEvent extends HospitalNotificationEvent {}
