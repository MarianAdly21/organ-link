import 'package:organ_link/apis/managers/user_manager/user_home_api_manager.dart';
import 'package:organ_link/apis/models/user_Home/user_home_date_send_model.dart';
import 'package:organ_link/features/user_flow/home/bloc/user_home_bloc.dart';
import 'package:organ_link/features/user_flow/home/model/user_home_data_ui_model.dart';

abstract class BaseUserHomeRepository {
  Future<UserHomeState> getUserHomeData({required int id});
    
}
class UserHomeRepository implements BaseUserHomeRepository {
  final UserHomeApiManager userHomeApiManager;

  UserHomeRepository({required this.userHomeApiManager});
  @override
  Future<UserHomeState> getUserHomeData({required int id})async {
   late UserHomeState userHomeState;
    userHomeApiManager.userHomeApi(UserHomeDateSendModel(id: id), (response){
     final model=UserHomeDataUiModel.fromApiModel(response.data!);
     userHomeState=UserHomeDataLoadedSuccessfullyState(userHomeDataUiModel:model );
    }, (error){
      userHomeState=UserHomeErrorState(errorMessage: error.message);
    });
   return userHomeState;
  }
}

