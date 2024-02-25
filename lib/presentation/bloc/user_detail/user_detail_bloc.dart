import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_fakestoreapi/domain/entities/users.dart';
import 'package:flutter_bloc_fakestoreapi/domain/usecases/get_user_detail.dart';

part 'user_detail_event.dart';
part 'user_detail_state.dart';

class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
  final UserDetail userDetail;
  UserDetailBloc({required this.userDetail}) : super(UserDetailInitial()) {
    on<FetchUserDetail>((event, emit) async {
      emit(UserDetailLoading());
      final result = await userDetail();
      result.fold((failure) => emit(UserDetailError(failure.message)),
          (user) => emit(UserDetailLoaded(user)));
    });
  }
}
