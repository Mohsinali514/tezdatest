part of 'user_login_bloc.dart';

abstract class UserLoginState {}

class UserLoginInitial extends UserLoginState {}

class UserLoginLoading extends UserLoginState {}

class UserLoginDone extends UserLoginState {
  final AuthEntity auth;
  UserLoginDone(this.auth);
}

class UserLoginError extends UserLoginState {
  final String message;
  UserLoginError(this.message);
}
