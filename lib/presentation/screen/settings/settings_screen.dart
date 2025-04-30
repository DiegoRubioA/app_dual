import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/locale_provider.dart';
import '../../providers/theme_provider.dart'; // <-- Importamos el theme provider
import '../../../l10n/l10n.dart';

// Importaciones:
// - `locale_provider` y `theme_provider`: controlan idioma y tema de la app con Riverpod.
// - `l10n.dart`: soporte para internacionalización (S.of(context)).

/// Pantalla de ajustes que permite cambiar el idioma y el tema de la aplicación.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Observa el idioma y modo de tema actuales desde sus respectivos providers.
    final locale = ref.watch(localeProvider);
    final themeMode = ref.watch(themeModeProvider);

    return Scaffold(
      appBar: AppBar(title: Text(S.of(context)!.settingsTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Selector de idioma
            Text(
              S.of(context)!.languageLabel,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            DropdownButton<Locale>(
              value: locale ?? Localizations.localeOf(context),
              onChanged: (Locale? newLocale) {
                ref.read(localeProvider.notifier).state = newLocale;
              },
              items: const [
                DropdownMenuItem(
                  value: Locale('es'),
                  child: Text('Español 🇪🇸'),
                ),
                DropdownMenuItem(
                  value: Locale('en'),
                  child: Text('English 🇺🇸'),
                ),
                DropdownMenuItem(
                  value: Locale('fr'),
                  child: Text('Français 🇫🇷'),
                ),
                DropdownMenuItem(
                  value: Locale('it'),
                  child: Text('Italiano 🇮🇹'),
                ),
                DropdownMenuItem(
                  value: Locale('de'),
                  child: Text('Deutsch 🇩🇪'),
                ),
              ],
            ),

            const Divider(height: 32),

            // Selector de tema (claro, oscuro, sistema)
            Text('Tema', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            DropdownButton<ThemeMode>(
              value: themeMode,
              onChanged: (ThemeMode? newThemeMode) {
                if (newThemeMode != null) {
                  ref.read(themeModeProvider.notifier).state = newThemeMode;
                }
              },
              items: const [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text('Automático'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text('Claro 🌞'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text('Oscuro 🌙'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
