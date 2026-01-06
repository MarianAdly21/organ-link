part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class ValidatePasswordAndIdNumberEvent extends LoginEvent{
  final GlobalKey<FormState> formKey;

 const ValidatePasswordAndIdNumberEvent({required this.formKey});
}
class LoginWithPasswordAndIdNumberEvent extends LoginEvent{
  final String identificationNumber;
  final String password;

 const LoginWithPasswordAndIdNumberEvent({required this.identificationNumber, required this.password});

}
