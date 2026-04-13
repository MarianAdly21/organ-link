import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:organ_link/features/ministry_flow/ministry_home/bloc/ministry_dashboard_repository.dart';
import 'package:organ_link/features/ministry_flow/ministry_home/models/ministry_dashboard_ui_model.dart';

part 'ministry_dashboard_event.dart';
part 'ministry_dashboard_state.dart';

class MinistryDashboardBloc
    extends Bloc<MinistryDashboardEvent, MinistryDashboardState> {
  final MinistryDashboardRepository ministryDashboardRepository;
  MinistryDashboardBloc(this.ministryDashboardRepository)
    : super(MinistryDashboardInitial()) {
    on<GetMinistryDashboardDataEvent>(_getMinistryDashboardEvent);
    on<NavigationToHospitalsScreenEvent>(_navigationToHospitalsScreenEvent);
    on<NavigationToNotificationScreenEvent>(
      _navigationToNotificationScreenEvent,
    );
    on<NavigationToSettingScreenEvent>(_navigationToSettingScreenEvent);
  }

  FutureOr<void> _getMinistryDashboardEvent(
    GetMinistryDashboardDataEvent event,
    Emitter<MinistryDashboardState> emit,
  ) async {
    emit(MinistryDashboardLoadingState());
    emit(await ministryDashboardRepository.getMinistryDashboardData());
  }

  FutureOr<void> _navigationToHospitalsScreenEvent(
    NavigationToHospitalsScreenEvent event,
    Emitter<MinistryDashboardState> emit,
  ) {
    emit(NavigationToHospitalsScreenState());
  }

  FutureOr<void> _navigationToNotificationScreenEvent(
    NavigationToNotificationScreenEvent event,
    Emitter<MinistryDashboardState> emit,
  ) {
    emit(NavigationToNotificationScreenState());
  }

  FutureOr<void> _navigationToSettingScreenEvent(
    NavigationToSettingScreenEvent event,
    Emitter<MinistryDashboardState> emit,
  ) {
    emit(NavigationToSettingScreenState());
  }
}
