part of 'user_detail_bloc.dart';

abstract class UserDetailState {}

class UserDetailInitial extends UserDetailState {}

class UserDetailLoading extends UserDetailState {}

class UserDetailLoaded extends UserDetailState {
  final UserEntity userEntity;
  UserDetailLoaded(this.userEntity);
}

class UserDetailError extends UserDetailState {
  final String message;
  UserDetailError(this.message);
}
