import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:organ_link/features/user_flow/procedure_scheduling/bloc/schedule_procedure_repository.dart';
import 'package:organ_link/features/user_flow/procedure_scheduling/models/schedule_procedure_ui_model.dart';

part 'schedule_procedure_event.dart';
part 'schedule_procedure_state.dart';

class ScheduleProcedureBloc
    extends Bloc<ScheduleProcedureEvent, ScheduleProcedureState> {
  final ScheduleProcedureRepository scheduleProcedureRepository;
  ScheduleProcedureBloc(this.scheduleProcedureRepository)
    : super(ScheduleProcedureInitial()) {
    on<GetScheduleProcedureDataEvent>(_getScheduleProcedureData);
  }

  FutureOr<void> _getScheduleProcedureData(
    GetScheduleProcedureDataEvent event,
    Emitter<ScheduleProcedureState> emit,
  ) async {
    emit(ScheduleProcedureLoadingState());
    emit(await scheduleProcedureRepository.getSurgeryData());
  }
}
