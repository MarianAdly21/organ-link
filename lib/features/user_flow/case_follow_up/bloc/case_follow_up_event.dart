part of 'case_follow_up_bloc.dart';

sealed class CaseFollowUpEvent extends Equatable {
  const CaseFollowUpEvent();

  @override
  List<Object> get props => [];
}


class GetCaseFollowUpDateEvent extends CaseFollowUpEvent {}

class NavToProcedureSchedulingScreenEvent extends CaseFollowUpEvent {}

