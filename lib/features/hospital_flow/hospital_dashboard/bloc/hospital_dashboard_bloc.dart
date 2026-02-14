import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:organ_link/features/hospital_flow/enum/nav_type.dart';
import 'package:organ_link/features/hospital_flow/hospital_dashboard/bloc/hospital_dashboard_repository.dart';
import 'package:organ_link/features/hospital_flow/hospital_dashboard/models/hospital_dashboard_ui_model.dart';

part 'hospital_dashboard_event.dart';
part 'hospital_dashboard_state.dart';

class HospitalDashboardBloc
    extends Bloc<HospitalDashboardEvent, HospitalDashboardState> {
  final HospitalDashboardRepository hospitalDashboardRepository;
  HospitalDashboardBloc(this.hospitalDashboardRepository)
    : super(HospitalDashboardInitial()) {
    on<NavToHospitalNotificationScreenEvent>(
      _navToHospitalNotificationScreenEvent,
    );
    on<NavToHospitalSettingScreenEvent>(_navToHospitalSettingScreenEvent);
    on<NavToMatchingScreenEvent>(_navToMatchingScreenEvent);
    on<NavToSurgeriesScreenEvent>(_navToSurgeriesScreenEvent);
    on<NavToViewPatientOrDonorScreenEvent>(_navToViewPatientOrDonorScreenEvent);
    on<GetHospitalDashboardDataEvent>(_getHospitalDashboardDataEvent);
  }

  FutureOr<void> _getHospitalDashboardDataEvent(
    GetHospitalDashboardDataEvent event,
    Emitter<HospitalDashboardState> emit,
  ) async {
    emit(HospitalDashboardLoadingState());
    emit(await hospitalDashboardRepository.getHospitalDashboardData());
  }

  FutureOr<void> _navToHospitalNotificationScreenEvent(
    NavToHospitalNotificationScreenEvent event,
    Emitter<HospitalDashboardState> emit,
  ) {
    emit(NavToHospitalNotificationScreenState());
  }

  FutureOr<void> _navToHospitalSettingScreenEvent(
    NavToHospitalSettingScreenEvent event,
    Emitter<HospitalDashboardState> emit,
  ) {
    emit(NavToHospitalSettingScreenState());
  }

  FutureOr<void> _navToMatchingScreenEvent(
    NavToMatchingScreenEvent event,
    Emitter<HospitalDashboardState> emit,
  ) {
    emit(NavToMatchingScreenState());
  }

  FutureOr<void> _navToSurgeriesScreenEvent(
    NavToSurgeriesScreenEvent event,
    Emitter<HospitalDashboardState> emit,
  ) {
    emit(NavToSurgeriesScreenState());
  }

  FutureOr<void> _navToViewPatientOrDonorScreenEvent(
    NavToViewPatientOrDonorScreenEvent event,
    Emitter<HospitalDashboardState> emit,
  ) {
    emit(NavToViewPatientOrDonorScreenState(type: event.type));
  }
}
