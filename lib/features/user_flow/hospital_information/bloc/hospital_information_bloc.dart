import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:organ_link/features/user_flow/hospital_information/bloc/hospital_information_repository.dart';
import 'package:organ_link/features/user_flow/hospital_information/models/hospital_information_ui_model.dart';

part 'hospital_information_event.dart';
part 'hospital_information_state.dart';

class HospitalInformationBloc
    extends Bloc<HospitalInformationEvent, HospitalInformationState> {
  final HospitalInformationRepository hospitalInformationRepository;
  HospitalInformationBloc(this.hospitalInformationRepository)
    : super(HospitalInformationInitial()) {
    on<GetHospitalInformationDataEvent>(_getHospitalInfoDataEvent);
  }

  FutureOr<void> _getHospitalInfoDataEvent(
    GetHospitalInformationDataEvent event,
    Emitter<HospitalInformationState> emit,
  ) async {
    emit(HospitalInformationLoadingState());
    emit(
      await hospitalInformationRepository.getHospitalInformationDetailsData(),
    );
  }
}
