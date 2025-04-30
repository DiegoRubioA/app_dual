import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Importaciones:
// - `material.dart` proporciona la clase `ThemeMode` y otros elementos visuales.
// - `flutter_riverpod` permite gestionar el estado de forma reactiva.

// Provider que controla el modo de tema (claro, oscuro o según el sistema).
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);
