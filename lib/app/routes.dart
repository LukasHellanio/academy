import 'package:encora_community/pages/managers/manager_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:encora_community/pages/splash/splash_page.dart';
import 'package:encora_community/pages/login/login_page.dart';
import 'package:encora_community/pages/home/home_page.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const SplashPage(),
  '/login': (context) => const LoginPage(),
  '/home': (context) => const HomePage(),
  '/manager': (context) => const ManagerDetailPage(),
};
