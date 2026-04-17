import 'package:organ_link/apis/managers/user_manager/user_api_manager.dart';
import 'package:organ_link/features/user_flow/notification/bloc/notification_user_bloc.dart';
import 'package:organ_link/features/user_flow/notification/models/notification_user_ui_model.dart';
import 'package:organ_link/preferences/preferences_manager.dart';

abstract class BaseNotificationUserRepository {
  Future<NotificationUserState> getNotificationUser();
}

class NotificationUserRepository implements BaseNotificationUserRepository {
  final UserApiManager userApiManager;
  final PreferencesManager preferencesManager;

  NotificationUserRepository({
    required this.userApiManager,
    required this.preferencesManager,
  });
  @override
  Future<NotificationUserState> getNotificationUser() async {
    late NotificationUserState notificationUserState;
    final int? id = await preferencesManager.getId();
    await userApiManager.getUserHomeDataApi(
      id!,
      (response) {
        final model = response.notificationList
            .map((e) => NotificationUserUiModel.fromApiModel(e))
            .toList();
        notificationUserState = NotificationUserDataLoadedSuccessfullyState(
          notificationUserUiModel: model,
        );
      },

      (error) {
        notificationUserState = NotificationUserErrorState(
          errorMessage: error.message,
          codeError: error.code,
        );
      },
    );

    return notificationUserState;
  }
}
