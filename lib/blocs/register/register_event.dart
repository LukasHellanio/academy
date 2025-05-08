import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object?> get props => [];
}

class NameChanged extends RegisterEvent {
  final String name;

  const NameChanged(this.name);

  @override
  List<Object?> get props => [name];
}

class EmailChanged extends RegisterEvent {
  final String email;

  const EmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}

class PasswordChanged extends RegisterEvent {
  final String password;

  const PasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

class ConfirmPasswordChanged extends RegisterEvent {
  final String confirmPassword;

  const ConfirmPasswordChanged(this.confirmPassword);

  @override
  List<Object?> get props => [confirmPassword];
}

class UserTypeChanged extends RegisterEvent {
  final String userType;

  const UserTypeChanged(this.userType);

  @override
  List<Object?> get props => [userType];
}

class Submitted extends RegisterEvent {
  const Submitted();

  @override
  List<Object?> get props => [];
}
