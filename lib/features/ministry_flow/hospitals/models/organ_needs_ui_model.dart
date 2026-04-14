
import 'package:organ_link/apis/models/ministry/hospitals_list/organ_needs_api_model.dart';

class OrganNeedsUiModel {
  final String organName;
  final int organCount;

  OrganNeedsUiModel({required this.organName, required this.organCount});
  factory OrganNeedsUiModel.fromApiModel(OrganNeedsApiModel e) {
    return OrganNeedsUiModel(
      organName: e.organName,
      organCount: e.organCount,
    );
  }
}
