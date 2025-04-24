// widgets/alternative_login_buttons.dart
import 'package:flutter/material.dart';
import 'custom_button.dart';

class AlternativeLoginButtons extends StatelessWidget {
  final VoidCallback onGoogleLogin;
  final VoidCallback onEncoraLogin;

  const AlternativeLoginButtons({
    super.key,
    required this.onGoogleLogin,
    required this.onEncoraLogin,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: CustomButton(
            onPressed: onGoogleLogin,
            label: 'Google Email',
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.all(14),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: CustomButton(
            onPressed: onEncoraLogin,
            label: 'Encora Account',
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.all(14),
            ),
          ),
        ),
      ],
    );
  }
}
