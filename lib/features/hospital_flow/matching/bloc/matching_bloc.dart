import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:organ_link/apis/models/hospital/match_api_model.dart';
import 'package:organ_link/features/hospital_flow/matching/bloc/matching_repository.dart';
import 'package:organ_link/features/hospital_flow/matching/models/match_ui_model.dart';

part 'matching_event.dart';
part 'matching_state.dart';

class MatchingBloc extends Bloc<MatchingEvent, MatchingState> {
  final MatchingRepository matchingRepository;
  MatchingBloc(this.matchingRepository) : super(MatchingInitial()) {
    on<GetMatchingDataEvent>(_getMatchingDataEvent);
    on<NavToMatchingDetailsScreenEvent>(_navToMatchingDetailsScreenEvent);
  }

  FutureOr<void> _getMatchingDataEvent(
    GetMatchingDataEvent event,
    Emitter<MatchingState> emit,
  ) async {
    emit(MatchingLoadingState());
    emit(await matchingRepository.getMatchingList());
  }

  FutureOr<void> _navToMatchingDetailsScreenEvent(
    NavToMatchingDetailsScreenEvent event,
    Emitter<MatchingState> emit,
  ) {
    emit(NavToMatchingDetailsScreenState(matchId: event.matchId));
  }
}
