import 'package:encora_community/pages/register/register_controller.dart';
import 'package:encora_community/widgets/custom_button.dart';
import 'package:encora_community/widgets/custom_text_field.dart';
import 'package:encora_community/widgets/password_strength_indicator.dart';
import 'package:encora_community/widgets/password_tips.dart';
import 'package:encora_community/widgets/password_match_status.dart';
import 'package:encora_community/widgets/alternative_login_buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  late final RegisterController _registerController;

  @override
  void initState() {
    super.initState();
    _registerController = RegisterController();
  }

  @override
  void dispose() {
    _registerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ChangeNotifierProvider.value(
      value: _registerController,
      child: Consumer<RegisterController>(
        builder: (context, controller, _) {
          return Form(
            key: controller.formKey,
            onChanged: () => setState(() {}),
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
                CustomTextField(
                  controller: controller.nameController,
                  label: 'Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  controller: controller.emailController,
                  label: 'Email',
                  validator: (value) {
                    if (value == null || !value.contains('@')) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  controller: controller.passwordController,
                  label: 'Password',
                  obscureText: true,
                  validator: (value) {
                    final strength = controller.evaluatePasswordStrength(
                      value ?? '',
                    );
                    if (strength != 'Strong') {
                      return 'Password must be strong';
                    }
                    return null;
                  },
                  onChanged: controller.updatePasswordStrength,
                ),
                PasswordTips(password: controller.passwordController.text),
                const SizedBox(height: 16),

                CustomTextField(
                  controller: controller.confirmPasswordController,
                  label: 'Confirm Password',
                  obscureText: true,
                  validator: (value) {
                    if (value != controller.passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),

                PasswordMatchStatus(
                  password: controller.passwordController.text,
                  confirmPassword: controller.confirmPasswordController.text,
                ),
                const SizedBox(height: 16),

                DropdownButtonFormField<String>(
                  value: controller.userType,
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
                      controller.userType = value;
                    }
                  },
                ),

                const SizedBox(height: 24),

                PasswordStrengthIndicator(
                  strength: controller.passwordStrength,
                ),
                const SizedBox(height: 24),

                AlternativeLoginButtons(
                  onGoogleLogin: () {}, // TODO: Google login
                  onEncoraLogin: () {}, // TODO: Encora login
                ),
                const SizedBox(height: 24),

                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        onPressed:
                            controller.formKey.currentState?.validate() ?? false
                                ? () async {
                                  await controller.registerUser(
                                    context,
                                    controller
                                        .nameController
                                        .text, // Passando o nome
                                    "", // Você pode preencher o avatarUrl mais tarde ou deixá-lo em branco por enquanto
                                  );
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
