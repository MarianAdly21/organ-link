import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:organ_link/features/ministry_flow/ministry_notification_details/bloc/ministry_notification_details_repository.dart';
import 'package:organ_link/features/ministry_flow/ministry_notification_details/models/ministry_notification_details_ui_model.dart';

part 'ministry_notification_details_event.dart';
part 'ministry_notification_details_state.dart';

class MinistryNotificationDetailsBloc
    extends
        Bloc<
          MinistryNotificationDetailsEvent,
          MinistryNotificationDetailsState
        > {
  final MinistryNotificationDetailsRepository
  ministryNotificationDetailsRepository;
  MinistryNotificationDetailsBloc(this.ministryNotificationDetailsRepository)
    : super(MinistryNotificationDetailsInitial()) {
    on<GetMinistryNotificationDetailsDataEvent>(
      _getMinistryNotificationDetailsDataEvent,
    );
  }

  FutureOr<void> _getMinistryNotificationDetailsDataEvent(
    GetMinistryNotificationDetailsDataEvent event,
    Emitter<MinistryNotificationDetailsState> emit,
  ) async {
    emit(MinistryNotificationDetailsLoadingState());
    emit(
      await ministryNotificationDetailsRepository
          .getMinistryNotificationDetailsData(event.id),
    );
  }
}
