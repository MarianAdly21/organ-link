import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:organ_link/features/ministry_flow/ministry_notification/bloc/ministry_notification_repository.dart';
import 'package:organ_link/features/ministry_flow/ministry_notification/models/ministry_notification_ui_model.dart';

part 'ministry_notification_event.dart';
part 'ministry_notification_state.dart';

class MinistryNotificationBloc
    extends Bloc<MinistryNotificationEvent, MinistryNotificationState> {
  final MinistryNotificationRepository ministryNotificationRepository;
  MinistryNotificationBloc(this.ministryNotificationRepository)
    : super(MinistryNotificationInitial()) {
    on<GetMinistryNotificationDataEvent>(_getMinistryNotificationDataEvent);
    on<NavToNotificationDetailsScreenEvent>(
      _navToNotificationDetailsScreenEvent,
    );
  }

  FutureOr<void> _getMinistryNotificationDataEvent(
    GetMinistryNotificationDataEvent event,
    Emitter<MinistryNotificationState> emit,
  ) async {
    emit(MinistryNotificationLoadingState());
    emit(await ministryNotificationRepository.getMinistryNotificationData());
  }

  FutureOr<void> _navToNotificationDetailsScreenEvent(
    NavToNotificationDetailsScreenEvent event,
    Emitter<MinistryNotificationState> emit,
  ) {
    emit(NavToNotificationDetailsScreenState(id: event.id));
  }
}
