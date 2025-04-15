// lib/widgets/login_form.dart

import 'package:encora_community/widgets/custom_button.dart';
import 'package:encora_community/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:encora_community/core/utils/validators.dart';

class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function onSubmit;

  const LoginForm({
    Key? key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Login',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 24),
          CustomTextField(
            controller: emailController,
            label: 'Email',
            validator: Validators.validateEmail,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: passwordController,
            label: 'Password',
            validator: Validators.validatePassword,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: MediaQuery.of(context).size.height * 0.5,
            child: CustomButton(
              onPressed: () => onSubmit(),
              label: 'Login',
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
