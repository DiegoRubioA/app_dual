import 'package:flutter/material.dart';
import 'core/theme/light_theme.dart';
import 'core/theme/dark_theme.dart';

// Pantallas principales de la app.
import 'package:app_dual/presentation/screen/home/home_screen.dart';
import 'package:app_dual/presentation/screen/details/details_screen.dart';
import 'package:app_dual/presentation/screen/create_post/create_post_screen.dart';
import 'package:app_dual/presentation/screen/profile/profile_screen.dart';
import 'package:app_dual/presentation/screen/settings/settings_screen.dart';
import 'package:app_dual/presentation/screen/splash/splash_screen.dart';

// Soporte de localización internacional.
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/l10n.dart';

// Gestión del estado con Riverpod.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'presentation/providers/locale_provider.dart';
import 'package:app_dual/presentation/providers/theme_provider.dart';

/// `AppDual` es el widget raíz de la aplicación.
/// Extiende `ConsumerWidget` para poder acceder a los providers de Riverpod.
class AppDual extends ConsumerWidget {
  const AppDual({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Observa el estado de la localización y el modo de tema (claro/oscuro).
    final locale = ref.watch(localeProvider);
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false, // Oculta la etiqueta de debug.
      title: 'App Dual', // Título de la app.
      theme: lightTheme, // Tema claro definido en archivos externos.
      darkTheme: darkTheme, // Tema oscuro definido en archivos externos.
      themeMode: themeMode, // Modo de tema actual (sistema, claro, oscuro).
      locale: locale, // Idioma actual de la app.
      localizationsDelegates: const [
        S.delegate, // Delegado de traducción generado.
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.supportedLocales, // Idiomas soportados.
      initialRoute: '/splash', // Ruta inicial al iniciar la app.
      routes: {
        // Mapa de rutas: define la navegación entre pantallas.
        '/': (context) => const HomeScreen(),
        '/details': (context) => const DetailsScreen(),
        '/create': (context) => const CreatePostScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/splash': (context) => const SplashScreen(),
      },
    );
  }
}
