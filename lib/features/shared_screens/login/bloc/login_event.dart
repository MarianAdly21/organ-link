part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class ValidateIdNumberAndPasswordEvent extends LoginEvent{
  final GlobalKey<FormState> loginFormKey ;

const  ValidateIdNumberAndPasswordEvent({required this.loginFormKey});
}

class LoginWithIdNumberAndPasswordEvent extends LoginEvent{
  final String password ;
  final String identificationNumber ;
 const LoginWithIdNumberAndPasswordEvent({required this.password, required this.identificationNumber});
}

 