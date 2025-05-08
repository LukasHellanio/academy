import 'package:encora_community/blocs/register/register_event.dart';
import 'package:encora_community/data/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:encora_community/blocs/register/register_bloc.dart';
import 'package:encora_community/blocs/register/register_state.dart';
import 'package:encora_community/widgets/buttons/custom_button.dart';
import 'package:encora_community/widgets/password/password_match_status.dart';
import 'package:encora_community/widgets/password/password_strength_indicator.dart';
import 'package:encora_community/widgets/password/password_tips.dart';
import 'package:encora_community/widgets/buttons/alternative_login_buttons.dart';
import 'package:encora_community/widgets/custom_text_field.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authService = AuthService();

    return BlocProvider(
      create: (_) => RegisterBloc(authService: authService),
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          final bloc = context.read<RegisterBloc>();
          final nameController = TextEditingController(text: state.name);
          final emailController = TextEditingController(text: state.email);
          final passwordController = TextEditingController(
            text: state.password,
          );
          final confirmController = TextEditingController(
            text: state.confirmPassword,
          );

          return Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 24),

                // Name
                CustomTextField(
                  label: 'Name',
                  controller: nameController,
                  onChanged: (value) => bloc.add(NameChanged(value)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Email
                CustomTextField(
                  label: 'Email',
                  controller: emailController,
                  onChanged: (value) => bloc.add(EmailChanged(value)),
                  validator: (value) {
                    if (value == null || !value.contains('@')) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Password
                CustomTextField(
                  label: 'Password',
                  controller: passwordController,
                  obscureText: true,
                  onChanged: (value) => bloc.add(PasswordChanged(value)),
                  validator: (value) {
                    if (state.passwordStrength != 'Strong') {
                      return 'Password must be strong';
                    }
                    return null;
                  },
                ),
                PasswordTips(password: state.password),
                const SizedBox(height: 16),

                // Confirm Password
                CustomTextField(
                  label: 'Confirm Password',
                  controller: confirmController,
                  obscureText: true,
                  onChanged: (value) => bloc.add(ConfirmPasswordChanged(value)),
                  validator: (value) {
                    if (value != state.password) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                PasswordMatchStatus(
                  password: state.password,
                  confirmPassword: state.confirmPassword,
                ),
                const SizedBox(height: 16),

                // Dropdown
                DropdownButtonFormField<String>(
                  value: state.userType,
                  decoration: const InputDecoration(labelText: 'User Type'),
                  dropdownColor: theme.colorScheme.primary,
                  style: const TextStyle(color: Colors.black),
                  items: const [
                    DropdownMenuItem(value: 'admin', child: Text('Admin')),
                    DropdownMenuItem(value: 'manager', child: Text('Manager')),
                    DropdownMenuItem(
                      value: 'commonUser',
                      child: Text('Common User'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      bloc.add(UserTypeChanged(value));
                    }
                  },
                ),

                const SizedBox(height: 24),
                PasswordStrengthIndicator(strength: state.passwordStrength),
                const SizedBox(height: 24),

                // Botões de login alternativo
                AlternativeLoginButtons(
                  onGoogleLogin: () {},
                  onEncoraLogin: () {},
                ),
                const SizedBox(height: 24),

                // Botão de confirmar
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        onPressed:
                            state.passwordStrength == 'Strong' &&
                                    state.password == state.confirmPassword
                                ? () {
                                  bloc.add(Submitted());
                                }
                                : null,
                        label: 'Confirm',
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: Colors.grey.shade300,
                          disabledForegroundColor: Colors.white70,
                          padding: const EdgeInsets.all(14),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                TextButton(
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).pushNamedAndRemoveUntil('/', (route) => false);
                  },
                  child: const Text('Back to login'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
