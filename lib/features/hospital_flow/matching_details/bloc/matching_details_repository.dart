import 'package:organ_link/apis/managers/hospital_manager/hospital_api_manager.dart';
import 'package:organ_link/features/hospital_flow/matching_details/bloc/matching_details_bloc.dart';
import 'package:organ_link/features/hospital_flow/matching_details/models/matching_details_ui_model.dart';

abstract class BaseMatchingDetailsRepository {
  Future<MatchingDetailsState> getMatchingDetailsData(int id);
}
class MatchingDetailsRepository implements BaseMatchingDetailsRepository {
    final HospitalApiManager hospitalApiManager;

  MatchingDetailsRepository({required this.hospitalApiManager});

  @override
  Future<MatchingDetailsState> getMatchingDetailsData(int id)async {
    late MatchingDetailsState matchingDetailsState;
    await hospitalApiManager.getMatchingDetailsDataApi(
      id,
      (response) {
        final model =
            MatchingDetailsUiModel.fromApiModel(response);
           
        matchingDetailsState = MatchingDetailsDataLoadedSuccessfullyState(
          matchingDetailsUiModel: model,
        );
      },
      (error) {
        matchingDetailsState = MatchingDetailsErrorState(
          errorMessage: error.message,
          codeError: error.code,
        );
      },
    );
    return matchingDetailsState;
  }
}