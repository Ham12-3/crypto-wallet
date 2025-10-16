import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../features/auth/presentation/pages/login_screen.dart';
import '../features/auth/presentation/pages/signup_screen.dart';
import '../features/portfolio/presentation/pages/portfolio_screen.dart';
import '../features/swap/presentation/pages/swap_screen.dart';
import '../features/swap/presentation/bloc/swap_bloc.dart';
import '../features/activities/presentation/pages/activities_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String portfolio = '/portfolio';
  static const String swap = '/swap';
  static const String activities = '/activities';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
      case '/':
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case signup:
        return MaterialPageRoute(builder: (_) => const SignupScreen());

      case home:
      case portfolio:
        return MaterialPageRoute(builder: (_) => const PortfolioScreen());

      case swap:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => SwapBloc(),
            child: const SwapScreen(),
          ),
        );

      case activities:
        return MaterialPageRoute(builder: (_) => const ActivitiesScreen());

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