// Importaciones:
// - `material.dart` provee los componentes visuales básicos de Flutter.
// - `flutter_riverpod` es para la gestión del estado de forma reactiva.
// - `app.dart` contiene el widget principal de la aplicación.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';

// Función principal que se ejecuta al iniciar la aplicación.
void main() {
  runApp(const ProviderScope(child: AppDual()));
}
