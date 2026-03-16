import 'package:organ_link/apis/managers/hospital_manager/hospital_api_manager.dart';
import 'package:organ_link/features/hospital_flow/matching/bloc/matching_bloc.dart';
import 'package:organ_link/features/hospital_flow/matching/models/match_ui_model.dart';
import 'package:organ_link/preferences/preferences_manager.dart';

abstract class BaseMatchingRepository {
  Future<MatchingState> getMatchingList();
}

class MatchingRepository implements BaseMatchingRepository {
  final HospitalApiManager hospitalApiManager;
  final PreferencesManager preferencesManager;

  MatchingRepository({
    required this.hospitalApiManager,
    required this.preferencesManager,
  });
  @override
  Future<MatchingState> getMatchingList() async {
    late MatchingState matchingState;
    final int? id = await preferencesManager.getId();
    await hospitalApiManager.getMatchesDataApi(
      id!,
      (response) {
        final model = MatchUiModel.fromApiModel(response);
        matchingState = MatchingDataLoadedSuccessfullyState(
          matchUiModel: model,
        );
      },
      (error) {
        matchingState = MatchingErrorState(
          errorMessage: error.message,
          codeError: error.code,
        );
      },
    );
    return matchingState;
  }
}
