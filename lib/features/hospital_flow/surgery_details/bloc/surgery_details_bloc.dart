import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:organ_link/features/hospital_flow/enum/nav_type.dart';
import 'package:organ_link/features/hospital_flow/surgery_details/bloc/surgery_details_repository.dart';
import 'package:organ_link/features/hospital_flow/surgery_details/models/surgery_details_ui_model.dart';

part 'surgery_details_event.dart';
part 'surgery_details_state.dart';

class SurgeryDetailsBloc
    extends Bloc<SurgeryDetailsEvent, SurgeryDetailsState> {
  final SurgeryDetailsRepository surgeryDetailsRepository;
  SurgeryDetailsBloc(this.surgeryDetailsRepository)
    : super(SurgeryDetailsInitial()) {
    on<GetSurgeryDetailsDataEvent>(_getSurgeryDetailsData);
    on<NavToPatientOrDonorDetailsScreenEvent>(
      _navToPatientOrDonorDetailsScreen,
    );
  }

  FutureOr<void> _getSurgeryDetailsData(
    GetSurgeryDetailsDataEvent event,
    Emitter<SurgeryDetailsState> emit,
  ) async {
    emit(SurgeryDetailsLoadingState());
    emit(await surgeryDetailsRepository.getSurgerDetails(event.id));
  }

  FutureOr<void> _navToPatientOrDonorDetailsScreen(
    NavToPatientOrDonorDetailsScreenEvent event,
    Emitter<SurgeryDetailsState> emit,
  ) {
    emit(NavToPatientOrDonorDetailsScreenState(id: event.id, type: event.type));
  }
}
