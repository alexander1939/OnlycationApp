import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

import 'core/theme/app_theme.dart';
import 'core/constants/app_constants.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'presentation/viewmodels/auth/login_viewmodel.dart';
import 'routes/app_router.dart';
import 'routes/route_names.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize shared preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  
  // Initialize Dio with base options
  final dio = Dio(BaseOptions(
    baseUrl: AppConstants.baseUrl,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  ));
  
  // Add interceptors for logging and auth
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) async {
      // Add auth token if available
      final token = sharedPreferences.getString(AppConstants.authTokenKey);
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
      return handler.next(options);
    },
    onError: (error, handler) async {
      // Handle 401 Unauthorized
      if (error.response?.statusCode == 401) {
        // TODO: Handle token refresh or redirect to login
      }
      return handler.next(error);
    },
  ));
  
  runApp(MyApp(
    sharedPreferences: sharedPreferences,
    dio: dio,
  ));
}

class MyApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;
  final Dio dio;

  const MyApp({
    Key? key,
    required this.sharedPreferences,
    required this.dio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Auth Repository
        Provider<AuthRepository>(
          create: (_) => AuthRepositoryImpl(dio, sharedPreferences),
        ),
        
        // Login ViewModel
        ChangeNotifierProvider(
          create: (context) => LoginViewModel(
            context.read<AuthRepository>(),
            sharedPreferences,
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Onlycation',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: AppRouteNames.login,
      ),
    );
  }
}
