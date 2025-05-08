import 'package:encora_community/blocs/auth/auth_bloc.dart';
import 'package:encora_community/blocs/auth/auth_event.dart';
import 'package:encora_community/blocs/auth/auth_state.dart';
import 'package:encora_community/core/utils/toast_utils.dart';
import 'package:encora_community/widgets/form/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _submitLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      // Dispatch the LoginRequested event
      context.read<AuthBloc>().add(
        LoginRequested(email: email, password: password),
      );
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
        alpha: (0.03 * 255).toDouble(),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (state is AuthError) {
            showCustomToast(context, state.message, "warning");
          }
        },
        child: Center(
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
      ),
    );
  }
}
