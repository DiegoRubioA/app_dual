import 'package:flutter/material.dart';
import '../constants/colors.dart';

/// Define el tema claro de la aplicación.
/// Se utiliza cuando el modo de visualización está configurado como claro.
final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light, // Tema claro predeterminado de Flutter.
  primaryColor: AppColors.primary, // Color principal personalizado.
  scaffoldBackgroundColor: AppColors.background, // Fondo claro para pantallas.
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.primary, // Color de fondo de la AppBar.
    foregroundColor: Colors.white, // Color de íconos y texto en la AppBar.
  ),
);
