import 'package:flutter/material.dart';

// Screens
import 'package:app_dual/screen/home_screen.dart';
import 'package:app_dual/screen/details_screen.dart';
import 'package:app_dual/screen/create_post_screen.dart';
import 'package:app_dual/screen/profile_screen.dart';
import 'package:app_dual/screen/settings_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ejemplo Navegación Ampliada',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/details': (context) => const DetailsScreen(),
        '/create': (context) => const CreatePostScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}
