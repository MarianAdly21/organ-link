import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:organ_link/features/hospital_flow/notification_screen/bloc/hospital_notification_repository.dart';
import 'package:organ_link/features/hospital_flow/notification_screen/model/hospital_notification_ui_model.dart';

part 'hospital_notification_event.dart';
part 'hospital_notification_state.dart';

class HospitalNotificationBloc
    extends Bloc<HospitalNotificationEvent, HospitalNotificationState> {
  final HospitalNotificationRepository hospitalNotificationRepository;
  HospitalNotificationBloc(this.hospitalNotificationRepository)
    : super(HospitalNotificationInitial()) {
    on<GetHospitalNotificationDataEvent>(_getHospitalNotification);
  }

  FutureOr<void> _getHospitalNotification(
    GetHospitalNotificationDataEvent event,
    Emitter<HospitalNotificationState> emit,
  ) async {
    emit(HospitalNotificationLoadingState());
    emit(await hospitalNotificationRepository.getHospitalNotification());
  }
}
