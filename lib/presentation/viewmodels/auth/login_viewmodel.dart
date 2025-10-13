import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/base/base_viewmodel.dart';
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
