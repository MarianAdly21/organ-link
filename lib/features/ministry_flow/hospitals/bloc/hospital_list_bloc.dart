import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:organ_link/features/ministry_flow/hospitals/bloc/hospital_list_repository.dart';
import 'package:organ_link/features/ministry_flow/hospitals/models/hospitals_list_ui_model.dart';

part 'hospital_list_event.dart';
part 'hospital_list_state.dart';

class HospitalListBloc extends Bloc<HospitalListEvent, HospitalListState> {
  final HospitalListRepository hospitalListRepository;
  HospitalListBloc(this.hospitalListRepository) : super(HospitalListInitial()) {
    on<GetHospitalListDataEvent>(_getHospitalListDataEvent);
    on<NavToHospitalDetailsScreenEvent>(_navToHospitalDetailsScreenEvent);
  }

  FutureOr<void> _getHospitalListDataEvent(
    GetHospitalListDataEvent event,
    Emitter<HospitalListState> emit,
  ) async {
    emit(HospitalListLoadingState());
    emit(await hospitalListRepository.getHospitalsList());
  }

  FutureOr<void> _navToHospitalDetailsScreenEvent(
    NavToHospitalDetailsScreenEvent event,
    Emitter<HospitalListState> emit,
  ) {
    emit(NavToHospitalDetailsScreenState(id: event.id));
  }
}
