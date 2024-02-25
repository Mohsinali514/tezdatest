import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_fakestoreapi/domain/entities/auth.dart';
import 'package:flutter_bloc_fakestoreapi/domain/usecases/user_login.dart';

part 'user_login_event.dart';
part 'user_login_state.dart';

class UserLoginBloc extends Bloc<UserLoginEvent, UserLoginState> {
  final UserLogin userLogin;
  UserLoginBloc({required this.userLogin}) : super(UserLoginInitial()) {
    on<FetchUserLogin>((event, emit) async {
      emit(UserLoginLoading());
      final result = await userLogin(event.email, event.password);
      result.fold((failure) => emit(UserLoginError(failure.message)),
          (auth) => emit(UserLoginDone(auth)));
    });
  }
}
