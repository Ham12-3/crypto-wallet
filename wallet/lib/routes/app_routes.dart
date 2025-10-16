import 'package:flutter/material.dart';
import '../features/auth/presentation/pages/login_screen.dart';
import '../features/auth/presentation/pages/signup_screen.dart';
import '../features/portfolio/presentation/pages/portfolio_screen.dart';
import '../features/onboarding/presentation/pages/onboarding_screen.dart';

class AppRoutes {
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String portfolio = '/portfolio';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onboarding:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());

      case login:
      case '/':
        return MaterialPageRoute(builder: (_) => LoginScreen());

      case signup:
        return MaterialPageRoute(builder: (_) => SignupScreen());

      case home:
      case portfolio:
        return MaterialPageRoute(builder: (_) => PortfolioScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}