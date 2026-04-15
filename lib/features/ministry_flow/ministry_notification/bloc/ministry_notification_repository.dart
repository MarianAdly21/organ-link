import 'package:organ_link/apis/managers/ministry_manager/ministry_api_manager.dart';
import 'package:organ_link/features/ministry_flow/ministry_notification/bloc/ministry_notification_bloc.dart';
import 'package:organ_link/features/ministry_flow/ministry_notification/models/ministry_notification_ui_model.dart';

abstract class BaseMinistryNotificationRepository {
  Future<MinistryNotificationState> getMinistryNotificationData();
}

class MinistryNotificationRepository
    implements BaseMinistryNotificationRepository {
  final MinistryApiManager ministryApiManager;

  MinistryNotificationRepository({required this.ministryApiManager});
  @override
  Future<MinistryNotificationState> getMinistryNotificationData() async {
    late MinistryNotificationState ministryNotificationState;
    await ministryApiManager.getMinistryNotificationData(
      (response) {
        final model = MinistryNotificationUiModel.fromApiModel(response);
        ministryNotificationState =
            MinistryNotificationDataLoadedSuccessfullyState(
              ministryNotificationUiModel: model,
            );
      },
      (error) {
        ministryNotificationState = MinistryNotificationErrorState(
          errorMessage: error.message,
          codeError: error.code,
        );
      },
    );
    return ministryNotificationState;
  }
}
