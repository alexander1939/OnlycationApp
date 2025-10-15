import 'package:flutter/material.dart';
import 'package:onlycation_app/presentation/screens/auth/login_screen.dart';
import 'package:onlycation_app/routes/route_names.dart';
import 'package:onlycation_app/presentation/screens/auth/register_screen.dart';

// Placeholder for the splash screen
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

// Placeholder for the home screen
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Home Screen')),
    );
  }
}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteNames.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRouteNames.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRouteNames.register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case AppRouteNames.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      // Add more routes here
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

  // Helper method to push a named route
  static Future<T?> push<T extends Object?>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.pushNamed(
      context,
      routeName,
      arguments: arguments,
    );
  }

  // Helper method to replace current route
  static Future<T?> replace<T extends Object?, TO extends Object?>(
    BuildContext context,
    String routeName, {
    TO? result,
    Object? arguments,
  }) {
    return Navigator.pushReplacementNamed(
      context,
      routeName,
      result: result,
      arguments: arguments,
    );
  }

  // Helper method to pop to a specific route
  static void popTo(BuildContext context, String routeName) {
    Navigator.popUntil(
      context,
      ModalRoute.withName(routeName),
    );
  }
}
