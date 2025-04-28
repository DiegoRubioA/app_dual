import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = false;
  bool _notifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
        backgroundColor: Colors.grey,
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Modo Oscuro'),
            value: _darkMode,
            onChanged: (val) => setState(() => _darkMode = val),
          ),
          SwitchListTile(
            title: const Text('Notificaciones'),
            value: _notifications,
            onChanged: (val) => setState(() => _notifications = val),
          ),
        ],
      ),
    );
  }
}
