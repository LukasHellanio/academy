import 'package:bloc/bloc.dart';
import 'package:encora_community/data/services/auth_service.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthService authService;

  LoginBloc({required this.authService}) : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    try {
      final user = await authService.loginWithEmail(
        event.email.trim(),
        event.password.trim(),
      );
      if (user != null) {
        emit(LoginSuccess());
      } else {
        emit(const LoginFailure('User not found.'));
      }
    } catch (e) {
      emit(LoginFailure('Login error: $e'));
    }
  }
}
