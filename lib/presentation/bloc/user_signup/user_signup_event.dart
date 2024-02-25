part of 'user_signup_bloc.dart';

@immutable
abstract class UserSignupEvent {}

class FetchUserSignup extends UserSignupEvent {
  final String name;
  final String email;
  final String password;

  FetchUserSignup({
    required this.name,
    required this.email,
    required this.password,
  });
}
