import 'package:equatable/equatable.dart';

class RegisterState extends Equatable {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final String userType;
  final String passwordStrength;
  final bool isSubmitting;
  final String? errorMessage;
  final bool isSuccess;

  const RegisterState({
    this.name = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.userType = 'commonUser',
    this.passwordStrength = '',
    this.isSubmitting = false,
    this.errorMessage,
    this.isSuccess = false,
  });

  RegisterState copyWith({
    String? name,
    String? email,
    String? password,
    String? confirmPassword,
    String? userType,
    String? passwordStrength,
    bool? isSubmitting,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return RegisterState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      userType: userType ?? this.userType,
      passwordStrength: passwordStrength ?? this.passwordStrength,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [
    name,
    email,
    password,
    confirmPassword,
    userType,
    passwordStrength,
    isSubmitting,
    errorMessage,
    isSuccess,
  ];
}
