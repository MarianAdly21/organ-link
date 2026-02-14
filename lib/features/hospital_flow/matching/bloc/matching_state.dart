part of 'matching_bloc.dart';

sealed class MatchingState extends Equatable {
  const MatchingState();

  @override
  List<Object> get props => [];
}

final class MatchingInitial extends MatchingState {}

class MatchingErrorState extends MatchingState {
  final String errorMessage;
  final int codeError;

  const MatchingErrorState({
    required this.errorMessage,
    required this.codeError,
  });
}

class MatchingLoadingState extends MatchingState {}

class MatchingDataLoadedSuccessfullyState extends MatchingState {
  final List<MatchingUiModel> matchingList;

  const MatchingDataLoadedSuccessfullyState({required this.matchingList});
}

class NavToMatchingDetailsScreenState extends MatchingState {
  final int matchId;

  const NavToMatchingDetailsScreenState({required this.matchId});

  @override
  List<Object> get props => [identityHashCode(this)];
}
