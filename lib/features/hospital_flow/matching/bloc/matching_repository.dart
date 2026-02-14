import 'package:organ_link/apis/_base/dio_api_manager.dart';
import 'package:organ_link/apis/managers/hospital_manager/hospital_api_manager.dart';
import 'package:organ_link/features/hospital_flow/matching/bloc/matching_bloc.dart';
import 'package:organ_link/features/hospital_flow/matching/models/matching_ui_model.dart';
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
    // final int? id = await preferencesManager.getId();
    await hospitalApiManager.getHospitalDataApi(
      1,
      (response) {
        final model = response.matchingList
            .map((x) => MatchingUiModel.fromApiModel(x))
            .toList();
        matchingState = MatchingDataLoadedSuccessfullyState(
          matchingList: model,
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
