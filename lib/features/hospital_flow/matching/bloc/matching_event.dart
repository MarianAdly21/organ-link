part of 'matching_bloc.dart';

sealed class MatchingEvent extends Equatable {
  const MatchingEvent();

  @override
  List<Object> get props => [];
}

class GetMatchingDataEvent extends MatchingEvent {}

class NavToMatchingDetailsScreenEvent extends MatchingEvent {}
