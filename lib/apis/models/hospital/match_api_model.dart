import 'package:organ_link/apis/models/hospital/match_list_api_model.dart';

class MatchApiModel {
  final List<MatchListApiModel> matchList;
  final int totalMatchesCount;
  final int underAnalysisMatchesCount;
  final int underReviewMatchesCount;
  final int underMatchingCount;

  MatchApiModel({
    required this.matchList,
    required this.totalMatchesCount,
    required this.underAnalysisMatchesCount,
    required this.underReviewMatchesCount,
    required this.underMatchingCount,
  });
  factory MatchApiModel.fromJson(Map<String, dynamic> json) {
    return MatchApiModel(
      totalMatchesCount: json["total_matches"],
      underAnalysisMatchesCount: json["analysis_matches_count"],
      underReviewMatchesCount: json["review_matches_count"],
      underMatchingCount: json["matching_matches_count"],
      matchList: (json["matches"] as List? ?? [])
          .map((x) => MatchListApiModel.formJson(x))
          .toList(),
    );
  }
}
