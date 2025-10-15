import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../routes/route_names.dart';
import '../../../core/utils/validators.dart';
import '../../viewmodels/auth/login_viewmodel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F5),
      body: Container(
        width: double.infinity,
        height: size.height, // 🔧 Evita la franja negra
        color: const Color(0xFFFAF9F5),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Consumer<LoginViewModel>(
              builder: (context, viewModel, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 40),

                    // 🦊 Logo y título
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(120),
                          child: Image.asset(
                            'assets/images/logo.png',
                            height: 140,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                const FlutterLogo(size: 140),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'OnlyCation',
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF2D8FA8),
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),

                    // 🧾 Contenedor del formulario
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Email
                            TextFormField(
                              controller: viewModel.emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: 'Correo electrónico',
                                labelStyle: const TextStyle(
                                  color: Color(0xFF444444),
                                ),
                                prefixIcon: const Icon(Icons.email_outlined),
                                filled: true,
                                fillColor: const Color(0xFFF7F8F9),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: const BorderSide(
                                      color: Color(0xFF8ED4BE)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: const BorderSide(
                                      color: Color(0xFF2D8FA8), width: 2),
                                ),
                              ),
                              validator: Validators.validateEmail,
                            ),
                            const SizedBox(height: 16),

                            // Password
                            TextFormField(
                              controller: viewModel.passwordController,
                              obscureText: _obscurePassword,
                              decoration: InputDecoration(
                                labelText: 'Contraseña',
                                labelStyle: const TextStyle(
                                  color: Color(0xFF444444),
                                ),
                                prefixIcon: const Icon(Icons.lock_outline),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: const Color(0xFF2D8FA8),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                                filled: true,
                                fillColor: const Color(0xFFF7F8F9),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: const BorderSide(
                                      color: Color(0xFF8ED4BE)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: const BorderSide(
                                      color: Color(0xFF2D8FA8), width: 2),
                                ),
                              ),
                              validator: Validators.validatePassword,
                            ),
                            const SizedBox(height: 12),

                            // Recordarme + Olvidaste
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      value: viewModel.rememberMe,
                                      onChanged: viewModel.toggleRememberMe,
                                      activeColor: const Color(0xFF8ED4BE),
                                    ),
                                    const Text('Recordarme'),
                                  ],
                                ),
                                TextButton(
                                  onPressed: () {
                                    // TODO: Navegar a recuperación
                                  },
                                  child: const Text(
                                    '¿Olvidaste tu contraseña?',
                                    style: TextStyle(
                                      color: Color(0xFF2D8FA8),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            if (viewModel.hasError)
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 12, top: 4),
                                child: Text(
                                  viewModel.error!,
                                  style: const TextStyle(color: Colors.red),
                                  textAlign: TextAlign.center,
                                ),
                              ),

                            // Botón principal
                            ElevatedButton(
                              onPressed: viewModel.isLoading
                                  ? null
                                  : () async {
                                      if (_formKey.currentState!.validate()) {
                                        final success =
                                            await viewModel.login();
                                        if (success && mounted) {
                                          Navigator.pushReplacementNamed(
                                              context, AppRouteNames.home);
                                        }
                                      }
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFF8B63),
                                foregroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                elevation: 4,
                              ),
                              child: viewModel.isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    )
                                  : const Text(
                                      'Iniciar sesión',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600),
                                    ),
                            ),

                            const SizedBox(height: 14),

                            // Botón TikTok mejorado
                            OutlinedButton.icon(
                              onPressed: viewModel.isLoading
                                  ? null
                                  : () {
                                      // TODO: Implementar TikTok OAuth
                                    },
                              icon: Stack(
                                children: const [
                                  Positioned(
                                      left: 1,
                                      top: 1,
                                      child: FaIcon(
                                        FontAwesomeIcons.tiktok,
                                        color: Colors.cyan,
                                        size: 20,
                                      )),
                                  Positioned(
                                      right: 1,
                                      bottom: 1,
                                      child: FaIcon(
                                        FontAwesomeIcons.tiktok,
                                        color: Colors.redAccent,
                                        size: 20,
                                      )),
                                  FaIcon(
                                    FontAwesomeIcons.tiktok,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ],
                              ),
                              label: const Text(
                                'Iniciar sesión con TikTok',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.black,
                                side: const BorderSide(
                                    color: Colors.black, width: 1),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                            ),

                            const SizedBox(height: 18),

                            // Registro
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('¿No tienes una cuenta? '),
                                TextButton(
                                  onPressed: () {
                                    // TODO: Ir a registro
                                  },
                                  child: const Text(
                                    'Regístrate',
                                    style: TextStyle(
                                      color: Color(0xFF2D8FA8),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
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
