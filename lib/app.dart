import 'package:flutter/material.dart';
import 'core/theme/light_theme.dart';
import 'core/theme/dark_theme.dart';

// Screens
import 'package:app_dual/presentation/screen/home/home_screen.dart';
import 'package:app_dual/presentation/screen/details/details_screen.dart';
import 'package:app_dual/presentation/screen/create_post/create_post_screen.dart';
import 'package:app_dual/presentation/screen/profile/profile_screen.dart';
import 'package:app_dual/presentation/screen/settings/settings_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:app_dual/presentation/screen/splash/splash_screen.dart';

import 'l10n/l10n.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'presentation/providers/locale_provider.dart';
import 'package:app_dual/presentation/providers/theme_provider.dart';

class AppDual extends ConsumerWidget {
  const AppDual({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Dual',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      locale: locale,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.supportedLocales,
      initialRoute: '/splash',
      routes: {
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
