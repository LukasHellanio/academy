// widgets/password_match_status.dart
import 'package:flutter/material.dart';

class PasswordMatchStatus extends StatelessWidget {
  final String password;
  final String confirmPassword;

  const PasswordMatchStatus({
    super.key,
    required this.password,
    required this.confirmPassword,
  });

  @override
  Widget build(BuildContext context) {
    if (confirmPassword.isEmpty) return const SizedBox.shrink();

    final bool match = password == confirmPassword;

    return Row(
      children: [
        Icon(
          match ? Icons.check_circle : Icons.cancel,
          color: match ? Colors.green : Colors.red,
          size: 18,
        ),
        const SizedBox(width: 6),
        Text(
          match ? 'Passwords match' : 'Passwords do not match',
          style: TextStyle(
            color: match ? Colors.green : Colors.red,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
