import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart'; // Necesario si se usa la clase Locale

/// Provider que gestiona el estado de la localización (idioma) de la aplicación.
/// Almacena un objeto `Locale?`, que puede ser `null` (para usar la del sistema) o un idioma específico.
final localeProvider = StateProvider<Locale?>((ref) => null);
