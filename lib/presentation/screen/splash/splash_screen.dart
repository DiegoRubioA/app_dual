import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Importaciones:
// - `material.dart`: para la estructura visual y animaciones.
// - `flutter_svg`: permite mostrar archivos SVG como imagen (usado para el logo).

/// Pantalla de presentación (SplashScreen) que se muestra al inicio de la app.
/// Aplica una animación de opacidad al logo SVG y redirige automáticamente a la pantalla principal.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0; // Nivel de opacidad del logo (para animación)

  @override
  void initState() {
    super.initState();

    // Espera 500 ms y luego inicia la animación de opacidad
    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      setState(() => _opacity = 1.0);
    });

    // Espera 5 segundos y redirige a la pantalla principal ('/')
    Future.delayed(const Duration(seconds: 5), () {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4285F4), // Azul Google
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(seconds: 2),
          curve: Curves.easeInOut,
          child: SvgPicture.asset(
            'assets/images/logo.svg', // Logo en formato SVG
            width: 150,
            height: 150,
          ),
        ),
      ),
    );
  }
}
