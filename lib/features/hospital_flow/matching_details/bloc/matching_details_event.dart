part of 'matching_details_bloc.dart';

sealed class MatchingDetailsEvent extends Equatable {
  const MatchingDetailsEvent();

  @override
  List<Object> get props => [];
}

final class GetMatchingDetailsDataEvent extends MatchingDetailsEvent {
  final int matchId;

  const GetMatchingDetailsDataEvent({required this.matchId});
}
