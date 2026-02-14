import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:organ_link/features/hospital_flow/matching_details/bloc/matching_details_repository.dart';
import 'package:organ_link/features/hospital_flow/matching_details/models/matching_details_ui_model.dart';

part 'matching_details_event.dart';
part 'matching_details_state.dart';

class MatchingDetailsBloc
    extends Bloc<MatchingDetailsEvent, MatchingDetailsState> {
  final MatchingDetailsRepository matchingDetailsRepository;
  MatchingDetailsBloc(this.matchingDetailsRepository)
    : super(MatchingDetailsInitial()) {
    on<GetMatchingDetailsDataEvent>(_getMatchingDetailsEvent);
  }

  FutureOr<void> _getMatchingDetailsEvent(
    GetMatchingDetailsDataEvent event,
    Emitter<MatchingDetailsState> emit,
  ) async {
    emit(MatchingDetailsLoadingState());
    emit(await matchingDetailsRepository.getMatchingDetailsData(event.matchId));
  }
}
