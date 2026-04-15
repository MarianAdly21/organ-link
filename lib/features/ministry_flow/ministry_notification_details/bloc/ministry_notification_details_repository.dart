import 'package:organ_link/apis/managers/ministry_manager/ministry_api_manager.dart';
import 'package:organ_link/features/ministry_flow/ministry_notification_details/bloc/ministry_notification_details_bloc.dart';
import 'package:organ_link/features/ministry_flow/ministry_notification_details/models/ministry_notification_details_ui_model.dart';

abstract class BaseMinistryNotificationDetailsRepository {
  Future<MinistryNotificationDetailsState> getMinistryNotificationDetailsData(
    int id,
  );
}

class MinistryNotificationDetailsRepository
    implements BaseMinistryNotificationDetailsRepository {
  final MinistryApiManager ministryApiManager;

  MinistryNotificationDetailsRepository({required this.ministryApiManager});
  @override
  Future<MinistryNotificationDetailsState> getMinistryNotificationDetailsData(
    int id,
  ) async {
    late MinistryNotificationDetailsState ministryNotificationDetailsState;
    await ministryApiManager.getMinistryNotificationDetailsData(
      id,
      (response) {
        final model = MinistryNotificationDetailsUiModel.fromApiModel(response);
        ministryNotificationDetailsState =
            MinistryNotificationDetailsDataLoadedSuccessfullyState(
              ministryNotificationDetailsUiModel: model,
            );
      },
      (error) {
        ministryNotificationDetailsState =
            MinistryNotificationDetailsErrorState(
              errorMessage: error.message,
              codeError: error.code,
            );
      },
    );
    return ministryNotificationDetailsState;
  }
}
