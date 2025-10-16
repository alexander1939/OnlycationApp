import 'package:flutter/material.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/base/base_viewmodel.dart';
import '../../../core/constants/app_constants.dart';
import '../../../data/models/auth/login_request.dart';
import '../../../domain/repositories/auth_repository.dart';

class LoginViewModel extends BaseViewModel {
  final AuthRepository _authRepository;
  final SharedPreferences _prefs;
  
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool rememberMe = false;
  
  LoginViewModel(this._authRepository, this._prefs);
  
  void toggleRememberMe(bool? value) {
    rememberMe = value ?? false;
    notifyListeners();
  }

  /// Registro como ESTUDIANTE con LinkedIn (móvil) usando deep link.
  /// Pide al backend la authorization_url específica para registrar estudiantes y
  /// espera el callback en `onlycation://auth` para recibir el token.
  Future<bool> registerStudentWithLinkedInMobile() async {
    setLoading(true);
    try {
      final redirectUri = '${AppConstants.oauthCallbackScheme}://${AppConstants.oauthCallbackHost}';
      final registerEndpoint = Uri.parse(AppConstants.baseUrl).replace(
        // User's backend path includes /api prefix
        path: 'api/auth/linkedin/register/student',
        queryParameters: {
          'redirect_uri': redirectUri,
        },
      );

      final resp = await http.get(registerEndpoint);
      if (resp.statusCode != 200) {
        setLoading(false);
        setError('No se pudo iniciar el registro con LinkedIn (HTTP ${resp.statusCode}).');
        return false;
      }
      final body = json.decode(resp.body) as Map<String, dynamic>;
      final authUrl = body['authorization_url'] as String?;
      if (authUrl == null || authUrl.isEmpty) {
        setLoading(false);
        setError('Respuesta inválida del servidor (sin authorization_url).');
        return false;
      }

      final resultUrl = await FlutterWebAuth2.authenticate(
        url: authUrl,
        callbackUrlScheme: AppConstants.oauthCallbackScheme,
      );

      final callback = Uri.parse(resultUrl);
      final token = callback.queryParameters['token'] ?? callback.queryParameters['access_token'];
      final message = callback.queryParameters['message'];
      final success = callback.queryParameters['success'];

      setLoading(false);

      if (token != null && token.isNotEmpty) {
        await _prefs.setString(AppConstants.authTokenKey, token);
        setError(null); // clear any stale error
        return true;
      }
      if (success == 'true') {
        setError(null);
        return true;
      }
      setError(message ?? 'No se pudo registrar con LinkedIn.');
      return false;
    } catch (e) {
      setLoading(false);
      // Si durante el flujo ya se guardó un token vía deep link handler, considera éxito
      final existing = _prefs.getString(AppConstants.authTokenKey);
      if (existing != null && existing.isNotEmpty) {
        setError(null);
        return true;
      }
      setError('Error al abrir LinkedIn. Verifica tu conexión e intenta nuevamente.');
      return false;
    }
  }

  /// Inicia el flujo de login con LinkedIn (móvil) usando deep link.
  /// Abre la URL de inicio en el backend y espera el callback en el esquema `onlycation://auth`.
  Future<bool> loginWithLinkedInMobile() async {
    setLoading(true);
    try {
      // 1) Pedimos al backend la authorization_url de LinkedIn
      final redirectUri = '${AppConstants.oauthCallbackScheme}://${AppConstants.oauthCallbackHost}';
      final loginEndpoint = Uri.parse(AppConstants.baseUrl).replace(
        // User's backend path includes /api prefix
        path: 'api/auth/linkedin/login',
        queryParameters: {
          'state': 'mobile',
          'redirect_uri': redirectUri, // Requiere soporte en backend para redirigir a esquema
        },
      );

      final resp = await http.get(loginEndpoint);
      if (resp.statusCode != 200) {
        setLoading(false);
        setError('No se pudo iniciar LinkedIn (HTTP ${resp.statusCode}).');
        return false;
      }
      final body = json.decode(resp.body) as Map<String, dynamic>;
      final authUrl = body['authorization_url'] as String?;
      if (authUrl == null || authUrl.isEmpty) {
        setLoading(false);
        setError('Respuesta inválida del servidor (sin authorization_url).');
        return false;
      }

      // 2) Abrimos el navegador al authorization_url y esperamos el callback onlycation://auth
      final resultUrl = await FlutterWebAuth2.authenticate(
        url: authUrl,
        callbackUrlScheme: AppConstants.oauthCallbackScheme,
      );

      final callback = Uri.parse(resultUrl);
      final token = callback.queryParameters['token'];
      final message = callback.queryParameters['message'];
      final success = callback.queryParameters['success'];

      setLoading(false);

      if (token != null && token.isNotEmpty) {
        await _prefs.setString(AppConstants.authTokenKey, token);
        setError(null); // clear any stale error
        return true;
      }

      if (success == 'true') {
        setError(null);
        return true;
      }

      setError(message ?? 'No se pudo iniciar sesión con LinkedIn.');
      return false;
    } catch (e) {
      setLoading(false);
      setError('Error al abrir LinkedIn. Verifica tu conexión e intenta nuevamente.');
      return false;
    }
  }
  
  Future<bool> login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      setError('Por favor ingrese su correo y contraseña');
      return false;
    }
    
    setLoading(true);
    
    try {
      final response = await _authRepository.login(
        LoginRequest(
          email: emailController.text.trim(),
          password: passwordController.text,
        ),
      );
      
      setLoading(false);
      
      if (response.success) {
        if (rememberMe) {
          await _prefs.setBool('remember_me', true);
        } else {
          await _prefs.remove('remember_me');
        }
        return true;
      } else {
        setError(response.message);
        return false;
      }
    } catch (e) {
      setLoading(false);
      setError('Error de conexión. Por favor, intente de nuevo.');
      return false;
    }
  }
  
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
