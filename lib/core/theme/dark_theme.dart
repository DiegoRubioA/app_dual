import 'package:flutter/material.dart';
import '../constants/colors.dart';

/// Define el tema oscuro de la aplicación utilizando `ThemeData`.
/// Este tema se aplica cuando el usuario selecciona modo oscuro o el sistema lo indica.
final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark, // Indica que el tema es oscuro.
  primaryColor: AppColors.primary, // Color primario personalizado.
  scaffoldBackgroundColor: Colors.black, // Fondo negro para toda la app.
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.primary, // Barra superior con el color primario.
    foregroundColor: Colors.white, // Iconos y texto de la AppBar en blanco.
  ),
);
