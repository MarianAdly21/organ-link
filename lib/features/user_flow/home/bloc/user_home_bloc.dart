import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:organ_link/features/user_flow/home/bloc/user_home_repository.dart';
import 'package:organ_link/features/user_flow/home/model/user_home_data_ui_model.dart';

part 'user_home_event.dart';
part 'user_home_state.dart';

class UserHomeBloc extends Bloc<UserHomeEvent, UserHomeState> {
  final UserHomeRepository userHomeRepository;
  UserHomeBloc(this.userHomeRepository) : super(UserHomeInitial()) {
    on<GetHomeUserDateEvent>(
      _getHomeUserDateEvent);

    on<NavToMedicalDetailsScreenEvent>(
      _navToDetailsScreen);  

    on<NavToCaseFollowUpScreenEvent>(
      _navToCaseFollowUpScreen
      );  

    on<NavToHospitalInfoScreenEvent>(_navToHospitalInfoScreen);

    on<NavToSettingScreenEvent>(
      _navToSettingScreen
    );  
    on<NavToNotificationScreenEvent>(
      _navToNotificationScreen
      );  
  }

  FutureOr<void> _navToNotificationScreen(NavToNotificationScreenEvent event, Emitter<UserHomeState> emit){emit(NavToNotificationScreenState());}

  FutureOr<void> _navToSettingScreen(NavToSettingScreenEvent event, Emitter<UserHomeState> emit){emit(NavToSettingScreenState());}

  FutureOr<void> _navToHospitalInfoScreen(NavToHospitalInfoScreenEvent event, Emitter<UserHomeState> emit){emit(NavToHospitalInfoScreenState());}

  FutureOr<void> _navToCaseFollowUpScreen(NavToCaseFollowUpScreenEvent event, Emitter<UserHomeState> emit){emit(NavToCaseFollowUpScreenState());}

  FutureOr<void> _navToDetailsScreen(NavToMedicalDetailsScreenEvent event, Emitter<UserHomeState> emit){emit(NavToMedicalDetailsScreenState());
  
  }
  

  FutureOr<void> _getHomeUserDateEvent(GetHomeUserDateEvent event,Emitter<UserHomeState> emit)async {
    emit(UserHomeLoadingState());
    emit(await userHomeRepository.getUserHomeData(id:event.id) );
    
  }
}
