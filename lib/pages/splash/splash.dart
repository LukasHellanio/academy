import 'package:encora_community/pages/login/login.dart';
import 'package:encora_community/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _showLogingButton = false;

  @override
  void initState() {
    super.initState();
    // Wait for 2 seconds, then show the login button instead of loading
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _showLogingButton = true;
      });
    });
  }

  void _goToLoginPage() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: theme.primaryColor, // Background color for the splash screen
      child: Stack(
        children: [
          // Centered icon
          const Center(
            child: Icon(Icons.menu_book, color: Colors.white, size: 100),
          ),
          // Positioned widget: either loading or button
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Center(
              child:
                  _showLogingButton
                      ? CustomLoginButton(
                        onPressed: _goToLoginPage,
                        label: 'Login',
                        icon: Icons.login,
                        iconColor: Colors.black,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: theme.primaryColor,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                      : const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
            ),
          ),
        ],
      ),
    );
  }
}
