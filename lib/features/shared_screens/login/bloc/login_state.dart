part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();
  
  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

 class LoginLoadingState extends LoginState {}
 class LoginErrorState extends LoginState {
  final String errorMessage;

 const LoginErrorState({required this.errorMessage});
 }
 class LoginValidateState extends LoginState {}
 class LoginNotValidateState extends LoginState {}

 class LoginSuccessfullyState extends LoginState {
  final LoginSuccessfulResponse loginSuccessfulResponse;

 const LoginSuccessfullyState({required this.loginSuccessfulResponse});
 }
 class OpenHomeScreenState extends LoginState {
  /// i want variable to identify the type of user
 }
