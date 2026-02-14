part of 'matching_details_bloc.dart';

sealed class MatchingDetailsState extends Equatable {
  const MatchingDetailsState();

  @override
  List<Object> get props => [];
}

final class MatchingDetailsInitial extends MatchingDetailsState {}

class MatchingDetailsErrorState extends MatchingDetailsState {
  final String errorMessage;
  final int codeError;

  const MatchingDetailsErrorState({
    required this.errorMessage,
    required this.codeError,
  });
}

class MatchingDetailsLoadingState extends MatchingDetailsState {}

class MatchingDetailsDataLoadedSuccessfullyState extends MatchingDetailsState {
  final MatchingDetailsUiModel matchingDetailsUiModel;

  const MatchingDetailsDataLoadedSuccessfullyState({
    required this.matchingDetailsUiModel,
  });
}
