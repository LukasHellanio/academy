import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class BiometricService {
  static final LocalAuthentication _auth = LocalAuthentication();

  static Future<bool> authenticate(BuildContext context) async {
    try {
      final bool canAuthenticate =
          await _auth.canCheckBiometrics || await _auth.isDeviceSupported();

      if (!canAuthenticate) {
        _showError(context, "Seu dispositivo não suporta biometria.");
        return false;
      }

      final bool didAuthenticate = await _auth.authenticate(
        localizedReason: 'Autentique-se para acessar o aplicativo',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
      return didAuthenticate;
    } catch (e) {
      _showError(context, "Erro ao tentar autenticar: ${e.toString()}");
      return false;
    }
  }

  static void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }
}
