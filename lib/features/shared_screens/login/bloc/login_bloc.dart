import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:organ_link/apis/models/auth/login/login_successful_response.dart';
import 'package:organ_link/features/shared_screens/login/bloc/login_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;
  LoginBloc(this.loginRepository) : super(LoginInitial()) {
    on<ValidateIdNumberAndPasswordEvent>(validateLoginEvent);

   on<LoginWithIdNumberAndPasswordEvent>(loginEvent);
  }

  FutureOr<void> loginEvent(LoginWithIdNumberAndPasswordEvent event,Emitter<LoginState> emit) async {
     emit(LoginLoadingState());
     emit(await loginRepository.loginWithIdNumberAndPassword(identificationNumber: event.identificationNumber, password: event.password));
   }

  FutureOr<void> validateLoginEvent(ValidateIdNumberAndPasswordEvent event,Emitter<LoginState> emit) { 
    if(event.loginFormKey.currentState?.validate()??false)
    {
      event.loginFormKey.currentState!.save();
      emit(LoginValidateState());
    } else{
      emit(LoginNotValidateState());

    }
  }
}


