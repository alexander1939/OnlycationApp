import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../routes/route_names.dart';
import '../../../core/utils/validators.dart';
import '../../viewmodels/auth/login_viewmodel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Consumer<LoginViewModel>(
              builder: (context, viewModel, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 40),
                    // Logo
                    Image.asset(
                      'assets/images/logo.png',
                      height: 120,
                      errorBuilder: (context, error, stackTrace) => const FlutterLogo(size: 120),
                    ),
                    const SizedBox(height: 40),
                    
                    // Email Field
                    TextFormField(
                      controller: viewModel.emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Correo electrónico',
                        prefixIcon: const Icon(Icons.email_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: Validators.validateEmail,
                    ),
                    const SizedBox(height: 16),
                    
                    // Password Field
                    TextFormField(
                      controller: viewModel.passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: Validators.validatePassword,
                    ),
                    const SizedBox(height: 8),
                    
                    // Remember Me & Forgot Password
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: viewModel.rememberMe,
                              onChanged: viewModel.toggleRememberMe,
                            ),
                            const Text('Recordarme'),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            // TODO: Implement forgot password
                          },
                          child: const Text('¿Olvidaste tu contraseña?'),
                        ),
                      ],
                    ),
                    
                    // Error Message
                    if (viewModel.hasError)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Text(
                          viewModel.error!,
                          style: const TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    
                    // Login Button
                    ElevatedButton(
                      onPressed: viewModel.isLoading
                          ? null
                          : () async {
                              if (_formKey.currentState!.validate()) {
                                final success = await viewModel.login();
                                if (success && mounted) {
                                  Navigator.pushReplacementNamed(context, AppRouteNames.home);
                                }
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: viewModel.isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            )
                          : const Text(
                              'INICIAR SESIÓN',
                              style: TextStyle(fontSize: 16),
                            ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Register Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('¿No tienes una cuenta? '),
                        TextButton(
                          onPressed: () {
                            // TODO: Navigate to register screen
                          },
                          child: const Text('Regístrate'),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
