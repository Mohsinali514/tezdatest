import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_fakestoreapi/domain/entities/auth.dart';
import 'package:flutter_bloc_fakestoreapi/domain/usecases/user_signup.dart';

part 'user_signup_event.dart';
part 'user_signup_state.dart';

class UserSignupBloc extends Bloc<UserSignupEvent, UserSignupState> {
  final UserSignup userSignup;

  UserSignupBloc({required this.userSignup}) : super(UserSignupInitial());

  @override
  Stream<UserSignupState> mapEventToState(UserSignupEvent event) async* {
    if (event is FetchUserSignup) {
      yield UserSignupLoading();
      final result = await userSignup(
        name: event.name,
        email: event.email,
        password: event.password,
      );
      yield* result.fold(
            (failure) async* {
          yield UserSignupError(failure.message);
        },
            (auth) async* {
          yield UserSignupDone(auth);
        },
      );
    }
  }
}
