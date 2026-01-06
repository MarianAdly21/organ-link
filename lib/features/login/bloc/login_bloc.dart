import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:organ_link/features/login/bloc/login_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final BaseLoginRepository loginRepository;
  LoginBloc(this.loginRepository) : super(LoginInitial()) {
    on<ValidatePasswordAndIdNumberEvent>(
      _validatePasswordAndIdNumberEvent
    );
    on<LoginWithPasswordAndIdNumberEvent>(
      _loginEvent
    );
  }

  FutureOr<void> _loginEvent(LoginWithPasswordAndIdNumberEvent event,Emitter<LoginState> emit)async {
  emit(LoginLoadingState());
  emit(
   await loginRepository.loginWithPasswordAndIdNumberApi(idNumber: event.identificationNumber, password: event.password));
    }

  FutureOr<void> _validatePasswordAndIdNumberEvent(ValidatePasswordAndIdNumberEvent event, Emitter<LoginState> emit) {
    if(event.formKey.currentState?.validate()?? false)
    {
      event.formKey.currentState!.save();
      emit(PasswordAndIdNumberValidatedState());
    }else{
      emit(PasswordAndIdNumberNotValidatedState());
    }
    
  }
}
