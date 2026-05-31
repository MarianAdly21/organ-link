import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:organ_link/features/user_flow/case_follow_up/bloc/case_follow_up_repository.dart';
import 'package:organ_link/features/user_flow/case_follow_up/models/case_follow_up_ui_model.dart';

part 'case_follow_up_event.dart';
part 'case_follow_up_state.dart';

class CaseFollowUpBloc extends Bloc<CaseFollowUpEvent, CaseFollowUpState> {
  final CaseFollowUpRepository caseFollowUpRepository;
  CaseFollowUpBloc(this.caseFollowUpRepository) : super(CaseFollowUpInitial()) {
    on<GetCaseFollowUpDateEvent>(_getCaseFollowUpData);
    on<NavToProcedureSchedulingScreenEvent>(
      _navToProcedureSchedulingScreenEvent,
    );
  }

  FutureOr<void> _getCaseFollowUpData(
    GetCaseFollowUpDateEvent event,
    Emitter<CaseFollowUpState> emit,
  ) async {
    emit(CaseFollowUpLoadingState());
    emit(await caseFollowUpRepository.geCaseFollowUpData());
  }

  FutureOr<void> _navToProcedureSchedulingScreenEvent(
    NavToProcedureSchedulingScreenEvent event,
    Emitter<CaseFollowUpState> emit,
  ) {
    emit(NavToProcedureSchedulingScreenState());
  }
}
