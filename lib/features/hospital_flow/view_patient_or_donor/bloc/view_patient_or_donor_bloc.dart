import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:organ_link/features/hospital_flow/enum/nav_type.dart';
import 'package:organ_link/features/hospital_flow/view_patient_or_donor/bloc/view_patient_or_donor_repository.dart';
import 'package:organ_link/features/hospital_flow/view_patient_or_donor/models/patient_or_donor_ui_model.dart';

part 'view_patient_or_donor_event.dart';
part 'view_patient_or_donor_state.dart';

class ViewPatientOrDonorBloc
    extends Bloc<ViewPatientOrDonorEvent, ViewPatientOrDonorState> {
  final ViewPatientOrDonorRepository viewPatientOrDonorRepository;
  ViewPatientOrDonorBloc(this.viewPatientOrDonorRepository)
    : super(ViewPatientOrDonorInitial()) {
    on<GetViewPatientOrDonorDataEvent>(_getList);
    on<NavToDetailsScreenEvent>(
      _navToDetailsScreenEvent,
    );
  }

  FutureOr<void> _navToDetailsScreenEvent(NavToDetailsScreenEvent event, Emitter<ViewPatientOrDonorState> emit) {
    emit(NavToDetailsScreenState(id: event.id));
  }

  FutureOr<void> _getList(
    GetViewPatientOrDonorDataEvent event,
    Emitter<ViewPatientOrDonorState> emit,
  ) async {
    emit(ViewPatientOrDonorLoadingState());
    if (event.type == NavType.donor) {
      emit(await viewPatientOrDonorRepository.getViewDonorData());
    } else if (event.type == NavType.patient) {
      emit(await viewPatientOrDonorRepository.getViewPatientData());
    }
  }
}
