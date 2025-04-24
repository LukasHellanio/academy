// widgets/password_strength_indicator.dart
import 'package:flutter/material.dart';
import '../core/utils/password_utils.dart';

class PasswordStrengthIndicator extends StatelessWidget {
  final String strength;

  const PasswordStrengthIndicator({super.key, required this.strength});

  @override
  Widget build(BuildContext context) {
    double value = 0.2;
    if (strength == "Medium") value = 0.5;
    if (strength == "Strong") value = 1.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password strength: $strength',
          style: TextStyle(
            color: PasswordUtils.getStrengthColor(strength),
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: value,
          color: PasswordUtils.getStrengthColor(strength),
          backgroundColor: Colors.grey[300],
        ),
      ],
    );
  }
}
