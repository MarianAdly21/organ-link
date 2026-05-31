part of 'case_follow_up_bloc.dart';

sealed class CaseFollowUpState extends Equatable {
  const CaseFollowUpState();

  @override
  List<Object> get props => [];
}

final class CaseFollowUpInitial extends CaseFollowUpState {}

class CaseFollowUpLoadingState extends CaseFollowUpState {}

class CaseFollowUpErrorState extends CaseFollowUpState {
  final String errorMessage;
  final int codeError;

  const CaseFollowUpErrorState({
    required this.errorMessage,
    required this.codeError,
  });
}

class NavToProcedureSchedulingScreenState extends CaseFollowUpState {}

class CaseFollowUpDataLoadedSuccessfullyState extends CaseFollowUpState {
  final CaseFollowUpUiModel caseFollowUpUiModel;

  const CaseFollowUpDataLoadedSuccessfullyState({
    required this.caseFollowUpUiModel,
  });
}
