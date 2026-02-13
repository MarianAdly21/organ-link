part of 'schedule_procedure_bloc.dart';

sealed class ScheduleProcedureEvent extends Equatable {
  const ScheduleProcedureEvent();

  @override
  List<Object> get props => [];
}
class GetScheduleProcedureDataEvent extends ScheduleProcedureEvent {}
