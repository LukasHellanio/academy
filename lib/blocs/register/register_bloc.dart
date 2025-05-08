import 'package:flutter_bloc/flutter_bloc.dart';
import 'register_event.dart';
import 'register_state.dart';
import 'package:encora_community/data/services/auth_service.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthService authService;

  RegisterBloc({required this.authService}) : super(const RegisterState()) {
    on<NameChanged>((event, emit) {
      emit(state.copyWith(name: event.name));
    });

    on<EmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });

    on<PasswordChanged>((event, emit) {
      final strength = _evaluatePasswordStrength(event.password);
      emit(
        state.copyWith(password: event.password, passwordStrength: strength),
      );
    });

    on<ConfirmPasswordChanged>((event, emit) {
      emit(state.copyWith(confirmPassword: event.confirmPassword));
    });

    on<UserTypeChanged>((event, emit) {
      emit(state.copyWith(userType: event.userType));
    });

    on<Submitted>(_onSubmitted);
  }

  Future<void> _onSubmitted(
    Submitted event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(isSubmitting: true));

    if (state.password != state.confirmPassword) {
      emit(
        state.copyWith(
          isSubmitting: false,
          errorMessage: 'Passwords do not match',
        ),
      );
      return;
    }

    try {
      await authService.registerUser(
        name: state.name,
        email: state.email,
        password: state.password,
        userType: state.userType,
      );
      emit(state.copyWith(isSubmitting: false, isSuccess: true));
    } catch (e) {
      emit(
        state.copyWith(
          isSubmitting: false,
          errorMessage: 'Registration failed: $e',
        ),
      );
    }
  }

  String _evaluatePasswordStrength(String password) {
    if (password.length > 8) {
      return 'Strong';
    } else if (password.length > 5) {
      return 'Medium';
    } else {
      return 'Weak';
    }
  }
}
