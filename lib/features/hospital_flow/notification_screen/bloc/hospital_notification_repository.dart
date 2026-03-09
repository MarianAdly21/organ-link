import 'package:organ_link/apis/managers/hospital_manager/hospital_api_manager.dart';
import 'package:organ_link/features/hospital_flow/notification_screen/bloc/hospital_notification_bloc.dart';
import 'package:organ_link/features/hospital_flow/notification_screen/model/hospital_notification_ui_model.dart';
import 'package:organ_link/preferences/preferences_manager.dart';

abstract class BaseHospitalNotificationRepository {
  Future<HospitalNotificationState> getHospitalNotification();
}

class HospitalNotificationRepository
    implements BaseHospitalNotificationRepository {
  final HospitalApiManager hospitalApiManager;
  final PreferencesManager preferencesManager;

  HospitalNotificationRepository({
    required this.hospitalApiManager,
    required this.preferencesManager,
  });
  @override
  Future<HospitalNotificationState> getHospitalNotification() async {
    late HospitalNotificationState hospitalNotificationState;
    final int? id = await preferencesManager.getId();
    await hospitalApiManager.getHospitalDataApi(
      id!,
      (response) {
        final model = HospitalNotificationUiModel.fromApiModel(
          response.hospitalNotificationApiModel,
        );
        hospitalNotificationState =
            HospitalNotificationDataLoadedSuccessfullyState(
              hospitalNotificationUiModel: model,
            );
      },

      (error) {
        hospitalNotificationState = HospitalNotificationErrorState(
          errorMessage: error.message,
          codeError: error.code,
        );
      },
    );

    return hospitalNotificationState;
  }
}
