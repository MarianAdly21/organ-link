import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:organ_link/features/ministry_flow/hospital_details/bloc/hospital_details_repository.dart';
import 'package:organ_link/features/ministry_flow/hospital_details/models/ministry_hospital_details_ui_model.dart';

part 'hospital_details_event.dart';
part 'hospital_details_state.dart';

class HospitalDetailsBloc
    extends Bloc<HospitalDetailsEvent, HospitalDetailsState> {
  final HospitalDetailsRepository hospitalDetailsRepository;
  HospitalDetailsBloc(this.hospitalDetailsRepository)
    : super(HospitalDetailsInitial()) {
    on<GetHospitalDetailsDataEvent>(_getHospitalDetailsDataEvent);
  }

  FutureOr<void> _getHospitalDetailsDataEvent(
    GetHospitalDetailsDataEvent event,
    Emitter<HospitalDetailsState> emit,
  ) async {
    emit(HospitalDetailsLoadingState());
    emit(await hospitalDetailsRepository.getHospitalDetailsData(event.id));
  }
}
