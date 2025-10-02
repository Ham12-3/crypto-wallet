import 'package:flutter/material.dart';
import '../features/auth/presentation/pages/login_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
      case '/':  // Add this to handle the root route
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      
      case signup:
        // TODO: Add signup screen
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Sign Up Screen')),
          ),
        );
      
      case home:
        // TODO: Add home screen
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Home Screen')),
          ),
        );
      
      default:
        // Always return a route, never return null
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