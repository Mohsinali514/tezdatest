part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthInitialCheckRequested extends AuthEvent {}

class AuthOnCurrentUserChanged extends AuthEvent {
  final AuthEntity? authEntity;

  AuthOnCurrentUserChanged(this.authEntity);
}

class AuthLogoutButtonPressed extends AuthEvent {}

class AuthLoginButtonPressed extends AuthEvent {
  final String email;
  final String password;
  AuthLoginButtonPressed(this.email, this.password);
}

class AuthUserSignupRequested extends AuthEvent {}

class AuthSignupButtonPressed extends AuthEvent { // Added
  final String name;
  final String email;
  final String password;

  AuthSignupButtonPressed(
    this.name,
    this.email,
    this.password,
  );
}
