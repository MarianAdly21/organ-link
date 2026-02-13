part of 'schedule_procedure_bloc.dart';

sealed class ScheduleProcedureState extends Equatable {
  const ScheduleProcedureState();
  
  @override
  List<Object> get props => [];
}

final class ScheduleProcedureInitial extends ScheduleProcedureState {}


class ScheduleProcedureErrorState extends ScheduleProcedureState {
  final String errorMessage;
  final int codeError;

  const ScheduleProcedureErrorState({
    required this.errorMessage,
    required this.codeError,
  });
}

class ScheduleProcedureLoadingState extends ScheduleProcedureState {}

class ScheduleProcedureDataLoadedSuccessfullyState
    extends ScheduleProcedureState {
  final  ScheduleProcedureUiModel scheduleProcedureUiModel;

const  ScheduleProcedureDataLoadedSuccessfullyState({required this.scheduleProcedureUiModel});

}
