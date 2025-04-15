import 'package:flutter/material.dart';
import 'package:encora_community/pages/splash/splash.dart';
import 'package:encora_community/pages/login/login.dart';
import 'package:encora_community/pages/home/home.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const SplashPage(),
  '/login': (context) => const LoginPage(),
  // '/home': (context) => const HomePage(),
};
