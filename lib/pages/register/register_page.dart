import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:encora_community/blocs/register/register_bloc.dart';
import 'package:encora_community/data/services/auth_service.dart';
import 'package:encora_community/widgets/form/register_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.primary.withValues(
        alpha: (0.03 * 255).toDouble(),
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
          child: BlocProvider(
            create: (_) => RegisterBloc(authService: AuthService()),
            child: const RegisterForm(),
          ),
        ),
      ),
    );
  }
}
