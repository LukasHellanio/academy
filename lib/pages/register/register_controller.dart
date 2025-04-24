import 'package:encora_community/data/services/auth_service.dart';
import 'package:encora_community/widgets/custom_toast.dart';
import 'package:flutter/material.dart';

class RegisterController extends ChangeNotifier {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Adicionando o controlador para o nome
  final _nameController = TextEditingController();

  String _userType = 'commonUser';
  String _passwordStrength = '';

  final AuthService _authService = AuthService();

  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;

  // Getter para o nameController
  TextEditingController get nameController => _nameController;

  String get passwordStrength => _passwordStrength;

  // Getter para userType
  String get userType => _userType;

  // Setter para userType
  set userType(String value) {
    _userType = value;
    notifyListeners();
  }

  void updatePasswordStrength(String password) {
    _passwordStrength = evaluatePasswordStrength(password);
    notifyListeners();
  }

  String evaluatePasswordStrength(String password) {
    if (password.length > 8) {
      return 'Strong';
    } else if (password.length > 5) {
      return 'Medium';
    } else {
      return 'Weak';
    }
  }

  Future<void> registerUser(
    BuildContext context,
    String name,
    String avatarUrl,
  ) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _authService.registerUser(
          context: context,
          name: name,
          email: _emailController.text,
          password: _passwordController.text,
          avatarUrl: avatarUrl,
          userType: _userType,
        );

        showToast(context, 'User successfully registered!', 'sucess');
        Navigator.pushReplacementNamed(context, '/home');
      } catch (e) {
        print('Registration failed: $e');
        showToast(context, 'Registration failed. Please try again.', 'danger');
      }
    }
  }

  void showToast(BuildContext context, String message, String type) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => CustomToast(message: message, type: type),
    );

    overlay.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    super.dispose();
  }
}
