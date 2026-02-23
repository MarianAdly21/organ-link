import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:organ_link/features/hospital_flow/surgeries/bloc/surgeries_repository.dart';
import 'package:organ_link/features/hospital_flow/surgeries/models/surgery_ui_model.dart';

part 'surgeries_event.dart';
part 'surgeries_state.dart';

class SurgeriesBloc extends Bloc<SurgeriesEvent, SurgeriesState> {
  final SurgeriesRepository surgeriesRepository;
  SurgeriesBloc(this.surgeriesRepository) : super(SurgeriesInitial()) {
     on<GetSurgeriesDataEvent>(_getList);
    on<NavToSurgeryDetailsScreenEvent>(
      _navToSurgeryScreenEvent,
    );
  }

 FutureOr<void> _navToSurgeryScreenEvent(NavToSurgeryDetailsScreenEvent event, Emitter<SurgeriesState> emit) {
    emit(NavToSurgeryDetailsScreenState(id: event.id));
  }

  FutureOr<void> _getList(
    GetSurgeriesDataEvent event,
    Emitter<SurgeriesState> emit,
  ) async {
    emit(SurgeriesLoadingState());
   
      emit(await surgeriesRepository.getSurgeriesList());
    
  }
}
