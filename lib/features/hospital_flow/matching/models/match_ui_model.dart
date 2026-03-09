import 'package:organ_link/apis/models/hospital/match_api_model.dart';
import 'package:organ_link/features/hospital_flow/matching/models/match_list_ui_model.dart';

class MatchUiModel {
  final List<MatchListUiModel> matchList;
  final int totalMatchesCount;
  final int underAnalysisMatchesCount;
  final int underReviewMatchesCount;
  final int underMatchingCount;
  MatchUiModel({
    required this.matchList,
    required this.totalMatchesCount,
    required this.underAnalysisMatchesCount,
    required this.underReviewMatchesCount,
    required this.underMatchingCount,
  });

  factory MatchUiModel.fromApiModel(MatchApiModel e) {
    return MatchUiModel(
      matchList: (e.matchList)
          .map((x) => MatchListUiModel.fromApiModel(x))
          .toList(),
      totalMatchesCount: e.totalMatchesCount,
      underAnalysisMatchesCount: e.underAnalysisMatchesCount,
      underReviewMatchesCount: e.underReviewMatchesCount,
      underMatchingCount: e.underMatchingCount,
    );
  }
}
