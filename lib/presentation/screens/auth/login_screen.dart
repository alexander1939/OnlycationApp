import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
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
  NativeAd? _nativeAd;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadNativeAd();
  }

  void _loadNativeAd() {
    final ad = NativeAd(
      adUnitId: 'ca-app-pub-3940256099942544/2247696110',
      factoryId: 'adFactoryExample',
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _nativeAd = ad as NativeAd;
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
      request: const AdRequest(),
    );
    ad.load();
  }

  @override
  void dispose() {
    _nativeAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F5),
      body: Container(
        width: double.infinity,
        height: size.height, // 
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

                    // Anuncio nativo (AdMob)
                    if (_isAdLoaded && _nativeAd != null)
                      Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.06),
                                  blurRadius: 12,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: SizedBox(
                                height: 100,
                                width: double.infinity,
                                child: AdWidget(ad: _nativeAd!),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 4,
                            right: 4,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () {
                                  setState(() {
                                    _nativeAd?.dispose();
                                    _nativeAd = null;
                                    _isAdLoaded = false;
                                  });
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(6.0),
                                  child: Icon(Icons.close, size: 20, color: Colors.black54),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    // Botón de información (About Us)
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(Icons.info_outline, color: Color(0xFF2D8FA8)),
                        tooltip: 'About us',
                        onPressed: () {
                          Navigator.pushNamed(context, AppRouteNames.about);
                        },
                      ),
                    ),

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
                                prefixIcon: const Icon(Icons.email_outlined, color: Color(0xFF2D8FA8)),
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
                              style: TextStyle(
                                color: viewModel.emailController.text.isEmpty
                                    ? Colors.grey
                                    : Colors.black,
                              ),
                              onChanged: (value) {
                                setState(() {}); // Esto hace que se reconstruya el TextFormField y cambie el color
                              },
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
                                prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF2D8FA8)),
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
                              style: TextStyle(
                                color: viewModel.passwordController.text.isEmpty
                                    ? Colors.grey
                                    : Colors.black,
                              ),
                              onChanged: (value) {
                                setState(() {}); // Esto hace que se reconstruya el TextFormField y cambie el color
                              },
                              validator: Validators.validatePassword,
                            ),
                            const SizedBox(height: 12),

                            // Recordarme + Olvidaste (responsive)
                            Wrap(
                              alignment: WrapAlignment.spaceBetween,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 12,
                              runSpacing: 8,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Checkbox(
                                      value: viewModel.rememberMe,
                                      onChanged: viewModel.toggleRememberMe,
                                      activeColor: const Color(0xFF8ED4BE),
                                    ),
                                    const Text('Recordarme'),
                                  ],
                                ),
                                ConstrainedBox(
                                  constraints: const BoxConstraints(maxWidth: 260),
                                  child: TextButton(
                                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                                    onPressed: () {
                                      // TODO: Navegar a recuperación
                                    },
                                    child: const Text(
                                      '¿Olvidaste tu contraseña?',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      style: TextStyle(
                                        color: Color(0xFF2D8FA8),
                                        fontWeight: FontWeight.w500,
                                      ),
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
                                  style: const TextStyle(color: Color.fromARGB(255, 255, 17, 0)),
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

                            // Botón LinkedIn (Deep Link - Móvil)
                            OutlinedButton.icon(
                              onPressed: viewModel.isLoading
                                  ? null
                                  : () async {
                                      final ok = await viewModel.loginWithLinkedInMobile();
                                      if (!mounted) return;
                                      if (ok) {
                                        Navigator.pushReplacementNamed(context, AppRouteNames.home);
                                      }
                                    },
                              icon: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE6F0F5), // 🔹 Fondo gris azulado suave
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Image.asset(
                                  'assets/icons/linkedin.png',
                                  height: 22,
                                  width: 22,
                                ),
                              ),
                              label: const Text(
                                'Iniciar sesión con LinkedIn',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                backgroundColor: const Color(0xFF0077B5), // 🔹 Azul corporativo de LinkedIn
                                side: const BorderSide(color: Color(0xFF0077B5), width: 1),
                                padding: const EdgeInsets.symmetric(vertical: 14),
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
                                const Text('¿No tienes una cuenta? ',
                                style: TextStyle(
                                  color: Color(0xFF444444),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, AppRouteNames.register);
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
