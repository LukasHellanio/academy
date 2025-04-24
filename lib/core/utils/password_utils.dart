import 'package:flutter/material.dart';

class PasswordUtils {
  static String evaluateStrength(String password) {
    int score = 0;

    if (password.length >= 6) score++;
    if (RegExp(r'[A-Z]').hasMatch(password)) score++;
    if (RegExp(r'[a-z]').hasMatch(password)) score++;
    if (RegExp(r'[0-9]').hasMatch(password)) score++;
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) score++;

    if (score <= 2) return "Weak";
    if (score == 3 || score == 4) return "Medium";
    return "Strong";
  }

  static Color getStrengthColor(String strength) {
    switch (strength) {
      case "Weak":
        return Colors.red;
      case "Medium":
        return Colors.orange;
      case "Strong":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  static Widget buildPasswordTips(String password) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTip("At least 6 characters", password.length >= 6),
        _buildTip("Uppercase letter", RegExp(r'[A-Z]').hasMatch(password)),
        _buildTip("Lowercase letter", RegExp(r'[a-z]').hasMatch(password)),
        _buildTip("Number", RegExp(r'[0-9]').hasMatch(password)),
        _buildTip(
          "Special character",
          RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password),
        ),
      ],
    );
  }

  static Widget _buildTip(String text, bool passed) {
    return Row(
      children: [
        Icon(
          passed ? Icons.check_circle : Icons.cancel,
          color: passed ? Colors.green : Colors.red,
          size: 16,
        ),
        const SizedBox(width: 8),
        Text(text, style: TextStyle(color: passed ? Colors.green : Colors.red)),
      ],
    );
  }
}
