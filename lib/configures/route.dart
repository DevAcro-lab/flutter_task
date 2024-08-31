import 'package:flutter/material.dart';
import 'package:flutter_task/feature/auth/views/signup_view.dart';
import 'package:flutter_task/feature/home/views/home_view.dart';
import 'package:flutter_task/feature/profile/views/profile_view.dart';
import 'package:flutter_task/feature/splash/views/splash_view.dart';
import 'package:flutter_task/utils/widgets/default_nav_bar.dart';
import '../feature/auth/views/login_view.dart';

class AppRoutes {
  static const String splash = '/';
  static const String navBar = '/navbar';
  static const String login = '/login';
  static const String signUp = '/signup';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case navBar:
        return MaterialPageRoute(builder: (_) => const NavBar());
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case login:
        return MaterialPageRoute(builder: (_) => LoginView());
      case signUp:
        return MaterialPageRoute(builder: (_) => const SignUpView());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Route not found'),
            ),
          ),
        );
    }
  }
}
