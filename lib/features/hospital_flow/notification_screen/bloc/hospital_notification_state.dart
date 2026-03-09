part of 'hospital_notification_bloc.dart';

sealed class HospitalNotificationState extends Equatable {
  const HospitalNotificationState();

  @override
  List<Object> get props => [];
}

final class HospitalNotificationInitial extends HospitalNotificationState {}

class HospitalNotificationErrorState extends HospitalNotificationState {
  final String errorMessage;
  final int codeError;

  const HospitalNotificationErrorState({
    required this.errorMessage,
    required this.codeError,
  });
}

class HospitalNotificationLoadingState extends HospitalNotificationState {}

class HospitalNotificationDataLoadedSuccessfullyState
    extends HospitalNotificationState {
  final HospitalNotificationUiModel hospitalNotificationUiModel;

  const HospitalNotificationDataLoadedSuccessfullyState({
    required this.hospitalNotificationUiModel,
  });
}
