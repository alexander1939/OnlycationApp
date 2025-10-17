import 'package:flutter/material.dart';
import 'package:onlycation_app/presentation/screens/auth/login_screen.dart';
import 'package:onlycation_app/routes/route_names.dart';
import 'package:onlycation_app/presentation/screens/about/about_screen.dart';
import 'package:onlycation_app/presentation/screens/auth/register_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:onlycation_app/core/constants/app_constants.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }

}

class _DeepLinkHandlerScreen extends StatefulWidget {
  final String token;
  const _DeepLinkHandlerScreen({Key? key, required this.token}) : super(key: key);

  @override
  State<_DeepLinkHandlerScreen> createState() => _DeepLinkHandlerScreenState();
}

class _DeepLinkHandlerScreenState extends State<_DeepLinkHandlerScreen> {
  @override
  void initState() {
    super.initState();
    _handleToken();
  }

  Future<void> _handleToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.authTokenKey, widget.token);
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, AppRouteNames.home);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

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
    // Handle deep link like '/?token=...'
    final name = settings.name ?? '';
    try {
      final uri = Uri.parse(name);
      final token = uri.queryParameters['token'];
      if (token != null && token.isNotEmpty) {
        return MaterialPageRoute(builder: (_) => _DeepLinkHandlerScreen(token: token));
      }
    } catch (_) {
      // ignore malformed uri
    }

    switch (settings.name) {
      case AppRouteNames.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRouteNames.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRouteNames.register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case AppRouteNames.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case AppRouteNames.about:
        return MaterialPageRoute(builder: (_) => const AboutScreen());
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
