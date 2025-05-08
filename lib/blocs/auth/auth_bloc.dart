import 'package:encora_community/data/services/auth_storage_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:encora_community/blocs/auth/auth_event.dart';
import 'package:encora_community/blocs/auth/auth_state.dart';
import '../../data/services/auth_service.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;

  AuthBloc({required this.authService}) : super(AuthInitial()) {
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final isLoggedIn = await authService.isUserLoggedIn();
      if (isLoggedIn) {
        final uid = authService.getCurrentUserId();
        emit(Authenticated(uid: uid));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
      emit(Unauthenticated());
    }
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final userData = await authService.loginWithEmail(
        event.email,
        event.password,
      );

      if (userData != null) {
        emit(Authenticated(uid: userData['uid']));
        await AuthStorageService.setLoggedIn(true);
      } else {
        emit(AuthError(message: 'Login failed. User data is null.'));
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
      emit(Unauthenticated());
    }
  }

  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final userData = await authService.registerUser(
        name: event.name,
        email: event.email,
        password: event.password,
        avatarUrl: event.avatarUrl,
        userType: event.userType,
      );

      if (userData != null) {
        emit(Authenticated(uid: userData['uid']));
      } else {
        emit(AuthError(message: 'Registration failed. User data is null.'));
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
      emit(Unauthenticated());
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await authService.logout();
    emit(Unauthenticated());
    await AuthStorageService.logout();
  }
}
