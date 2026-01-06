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
class  PasswordAndIdNumberValidatedState extends LoginState {}
class  PasswordAndIdNumberNotValidatedState extends LoginState {}
class  LoginSuccessfullyState extends LoginState {}
