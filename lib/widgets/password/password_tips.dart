// widgets/password_tips.dart
import 'package:flutter/material.dart';
import '../../core/utils/password_utils.dart';

class PasswordTips extends StatelessWidget {
  final String password;

  const PasswordTips({super.key, required this.password});

  @override
  Widget build(BuildContext context) {
    if (password.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        PasswordUtils.buildPasswordTips(password),
      ],
    );
  }
}
