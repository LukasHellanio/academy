// lib/pages/login/login_page.dart

import 'package:encora_community/core/utils/toast_utils.dart';
import 'package:encora_community/data/services/auth_service.dart';
import 'package:encora_community/widgets/login_form.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _submitLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      // Calling Firebase Auth login
      final user = await _authService.loginWithEmail(context, email, password);

      if (user != null) {
        // AuthService already searches for data and stores it globally
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      } else {
        showCustomToast(context, 'User not found.', "warning");
      }
    } catch (e) {
      // Display error message if login fails
      showCustomToast(context, 'Login error: $e', "warning");
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.primary.withValues(
        alpha: (0.3 * 255).toDouble(),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: LoginForm(
            formKey: _formKey,
            emailController: _emailController,
            passwordController: _passwordController,
            onSubmit: _submitLogin,
          ),
        ),
      ),
    );
  }
}
