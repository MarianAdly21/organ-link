import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:organ_link/features/user_flow/notification/bloc/notification_user_repository.dart';
import 'package:organ_link/features/user_flow/notification/models/notification_user_ui_model.dart';

part 'notification_user_event.dart';
part 'notification_user_state.dart';

class NotificationUserBloc
    extends Bloc<NotificationUserEvent, NotificationUserState> {
  final NotificationUserRepository notificationUserRepository;
  NotificationUserBloc(this.notificationUserRepository)
    : super(NotificationUserInitial()) {
    on<GetNotificationUserDataEvent>(_getNotificationUserList);
  }

  FutureOr<void> _getNotificationUserList(
    GetNotificationUserDataEvent event,
    Emitter<NotificationUserState> emit,
  ) async {
    emit(NotificationUserLoadingState());
    emit(await notificationUserRepository.getNotificationUser());
  }
}
