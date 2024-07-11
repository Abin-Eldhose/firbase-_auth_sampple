part of 'auth_bloc_bloc.dart';

@immutable
sealed class AuthBlocEvent {}

class CheckLoginStatusEvent extends AuthBlocEvent {}

//login event
class LoginEvent extends AuthBlocEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}

//signup event
class SignUpEvent extends AuthBlocEvent {
  final UserModel user;

  SignUpEvent({required this.user});
}

//logout evnet
class LogOutEvent extends AuthBlocEvent {}
