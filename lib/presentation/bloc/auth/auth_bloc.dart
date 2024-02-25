import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_fakestoreapi/domain/entities/auth.dart';
import 'package:flutter_bloc_fakestoreapi/domain/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  StreamSubscription<AuthEntity?>? _userSubscription;
  final AuthRepository _authRepository;
  AuthBloc(this._authRepository) : super(AuthLoading()) {
    on<AuthInitialCheckRequested>(_onInitialAuthChecked);
    on<AuthLogoutButtonPressed>(_onLogoutButtonPressed);
    on<AuthLoginButtonPressed>(_onLoginButtonPressed);
    on<AuthSignupButtonPressed>(_onSignupButtonPressed);
    on<AuthOnCurrentUserChanged>(_onCurrentUserChanged);
    _startUserSubscription();
  }

  Future<void> _onLoginButtonPressed(
      AuthLoginButtonPressed event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final failureOrAuth =
        await _authRepository.login(event.email, event.password);
    failureOrAuth.fold(
        (failure) => emit(AuthUserUnauthenticated(message: failure.message)),
        (authEntity) async {
      emit(AuthUserAuthenticated(authEntity));
    });
  }

  Future<void> _onSignupButtonPressed( // Added
      AuthSignupButtonPressed event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final failureOrAuth =
    await _authRepository.signup(event.name, event.email, event.password);
    failureOrAuth.fold(
            (failure) => emit(AuthUserUnauthenticated(message: failure.message)),
            (authEntity) async {
          emit(AuthUserAuthenticated(authEntity));
        });
  }

  Future<void> _onInitialAuthChecked(
      AuthInitialCheckRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _authRepository.checkSignedStatus();
    result.fold((l) => emit(AuthUserUnauthenticated()),
        (r) => emit(AuthUserAuthenticated(r)));
  }

  Future<void> _onLogoutButtonPressed(
      AuthLogoutButtonPressed event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await _authRepository.logout();
    emit(AuthUserUnauthenticated());
  }

  Future<void> _onCurrentUserChanged(
          AuthOnCurrentUserChanged event, Emitter<AuthState> emit) async =>
      event.authEntity != null
          ? emit(AuthUserAuthenticated(event.authEntity!))
          : emit(AuthUserUnauthenticated());

  void _startUserSubscription() => _userSubscription = _authRepository
      .getCurrentUser()
      .listen((auth) => add(AuthOnCurrentUserChanged(auth)));

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
