import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:organ_link/features/user_flow/medical_details/bloc/medical_details_repository.dart';
import 'package:organ_link/features/user_flow/medical_details/models/medical_details_ui_model.dart';

part 'medical_details_event.dart';
part 'medical_details_state.dart';

class MedicalDetailsBloc extends Bloc<MedicalDetailsEvent, MedicalDetailsState> {
  final MedicalDetailsRepository medicalDetailsRepository;
  MedicalDetailsBloc(this.medicalDetailsRepository) : super(MedicalDetailsInitial()) {
    on<GetMedicalDetailsDataEvent>(
      _getMedicalDataEvent);
  }

  FutureOr<void> _getMedicalDataEvent(GetMedicalDetailsDataEvent event,Emitter<MedicalDetailsState> emit) async{
    emit(MedicalDetailsLoadingState());
    emit(await medicalDetailsRepository.getMedicalDetailsData());
  }
}
