part of 'auth_bloc_bloc.dart';

@immutable
sealed class AuthBlocState {}

final class AuthBlocInitial extends AuthBlocState {}

//loading state
class AuthLoading extends AuthBlocState {}

//state when user is authenticated
class Authenticated extends AuthBlocState {
  User? user;
  Authenticated({required this.user});
}

//state when user is not authenticated
class UnAuthenticated extends AuthBlocState {}

class AuthenticationError extends AuthBlocState {
  final String message;

  AuthenticationError({required this.message});
}
