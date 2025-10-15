import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _apellidosController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _acceptedPrivacy = false;

  // Validador de contraseña
  bool _validatePassword(String value) {
    final hasUppercase = value.contains(RegExp(r'[A-Z]'));
    final hasSpecial = value.contains(RegExp(r'[!@#\$&*~%^+=?¿.,;:_-]'));
    final hasMinLength = value.length >= 8;
    return hasUppercase && hasSpecial && hasMinLength;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F5),
      body: Container(
        width: double.infinity,
        height: size.height,
        color: const Color(0xFFFAF9F5),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // --- Logo y título ---
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
                      'Crea tu cuenta',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF2D8FA8),
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),

                // --- Formulario ---
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Nombre
                        TextFormField(
                          controller: _nombreController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person_outline,
                                color: Color(0xFF2D8FA8)),
                            labelText: 'Nombre',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          style: TextStyle(
                            color: _nombreController.text.isEmpty
                                ? Colors.grey
                                : Colors.black,
                          ),
                          onChanged: (value) {
                            setState(() {}); // Esto hace que se reconstruya el TextFormField y cambie el color
                          },
                          validator: (value) =>
                              value!.isEmpty ? 'Ingrese su nombre' : null,
                        ),
                        const SizedBox(height: 16),

                        // Apellidos
                        TextFormField(
                          controller: _apellidosController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person,
                                color: Color(0xFF2D8FA8)),
                            labelText: 'Apellidos',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          style: TextStyle(
                            color: _apellidosController.text.isEmpty
                                ? Colors.grey
                                : Colors.black,
                          ),
                          onChanged: (value) {
                            setState(() {}); // Esto hace que se reconstruya el TextFormField y cambie el color
                          },
                          validator: (value) =>
                              value!.isEmpty ? 'Ingrese sus apellidos' : null,
                        ),
                        const SizedBox(height: 16),

                        // Contraseña
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock_outline,
                                color: Color(0xFF2D8FA8)),
                            labelText: 'Contraseña',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: const Color(0xFF444444),
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),
                          style: TextStyle(
                            color: _passwordController.text.isEmpty
                                ? Colors.grey
                                : Colors.black,
                          ),
                          onChanged: (value) {
                            setState(() {}); // Esto hace que se reconstruya el TextFormField y cambie el color
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ingrese una contraseña';
                            } else if (!_validatePassword(value)) {
                              return 'Debe tener al menos 8 caracteres,\nuna mayúscula y un caracter especial';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // Confirmar contraseña
                        TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: _obscureConfirm,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock,
                                color: Color(0xFF2D8FA8)),
                            labelText: 'Confirmar contraseña',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureConfirm
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: const Color(0xFF444444),
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureConfirm = !_obscureConfirm;
                                });
                              },
                            ),
                          ),
                          style: TextStyle(
                            color: _confirmPasswordController.text.isEmpty
                                ? Colors.grey
                                : Colors.black,
                          ),
                          onChanged: (value) {
                            setState(() {}); // Esto hace que se reconstruya el TextFormField y cambie el color
                          },
                          validator: (value) {
                            if (value != _passwordController.text) {
                              return 'Las contraseñas no coinciden';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // Checkbox de privacidad
                        Row(
                          children: [
                            Checkbox(
                              value: _acceptedPrivacy,
                              activeColor: const Color(0xFF444444),
                              onChanged: (value) {
                                setState(() {
                                  _acceptedPrivacy = value ?? false;
                                });
                              },
                            ),
                            Expanded(
                              child: Text.rich(
                                TextSpan(
                                  text: 'Acepto el ',
                                  style: GoogleFonts.poppins(fontSize: 14, color: const Color(0xFF444444),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'aviso de privacidad',
                                      style: const TextStyle(
                                        color: Color(0xFF2D8FA8),
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Botón de registro
                        ElevatedButton(
                          onPressed: _acceptedPrivacy
                              ? () {
                                  if (_formKey.currentState!.validate()) {
                                    // Aquí irá tu lógica de registro
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Registrando usuario...')),
                                    );
                                  }
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2D8FA8),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            disabledBackgroundColor:
                                Colors.grey.shade400, // si no acepta privacidad
                          ),
                          child: const Text('Registrarse'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
