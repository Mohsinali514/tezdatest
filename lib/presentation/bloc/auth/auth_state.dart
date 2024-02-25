part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthLoading extends AuthState {}

class AuthUserAuthenticated extends AuthState {
  final AuthEntity authEntity;

  AuthUserAuthenticated(this.authEntity);
}

class AuthUserUnauthenticated extends AuthState {
  String? message;
  AuthUserUnauthenticated({this.message});
}

class AuthSignupSuccess extends AuthState { // Added
  final AuthEntity authEntity;

  AuthSignupSuccess(this.authEntity);
}
