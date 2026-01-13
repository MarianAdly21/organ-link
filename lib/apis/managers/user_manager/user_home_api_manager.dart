import 'package:dio/dio.dart';
import 'package:organ_link/apis/_base/dio_api_manager.dart';
import 'package:organ_link/apis/errors/error_api_model.dart';
import 'package:organ_link/apis/models/user_Home/user_home_data_wrapper.dart';
import 'package:organ_link/apis/models/user_Home/user_home_date_send_model.dart';

class UserHomeApiManager {
  final DioApiManager dioApiManager;

  UserHomeApiManager(this.dioApiManager);
  Future<void> userHomeApi(
    UserHomeDateSendModel userHomeDateSendModel,
    void Function(UserHomeDataWrapper) success ,
    void Function(ErrorApiModel) fail, 
  )async
   {
    await dioApiManager.dio.get("").then(
      (response){
        final Map<String,dynamic> extractedData=response.data as Map<String,dynamic>;
        final UserHomeDataWrapper wrapper=UserHomeDataWrapper.fromJson(extractedData);
        success(wrapper);
      }

    ).onError((DioException error, stackTrace) {
          fail(ErrorApiModel.fromDioError(error));
        }).catchError((error){
      fail(ErrorApiModel.identifyError(error: error));
    });


   }
}