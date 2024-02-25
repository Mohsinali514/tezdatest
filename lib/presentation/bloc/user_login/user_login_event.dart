part of 'user_login_bloc.dart';

abstract class UserLoginEvent {}

class FetchUserLogin extends UserLoginEvent {
  final String email;
  final String password;
  FetchUserLogin(this.email, this.password);
}
