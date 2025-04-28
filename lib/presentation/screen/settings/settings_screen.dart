import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/locale_provider.dart';
import '../../../l10n/l10n.dart'; // Ajusta si tu ruta de import cambia

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);

    return Scaffold(
      appBar: AppBar(title: Text(S.of(context)!.settingsTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
