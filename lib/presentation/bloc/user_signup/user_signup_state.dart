part of 'user_signup_bloc.dart';

@immutable
abstract class UserSignupState {}

class UserSignupInitial extends UserSignupState {}

class UserSignupLoading extends UserSignupState {}

class UserSignupError extends UserSignupState {
  final String message;

  UserSignupError(this.message);
}

class UserSignupDone extends UserSignupState {
  final AuthEntity auth;

  UserSignupDone(this.auth);
}
