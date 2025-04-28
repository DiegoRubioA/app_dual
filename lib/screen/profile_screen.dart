import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Perfil'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://…/avatar.jpg'),
            ),
            SizedBox(height: 16),
            Text(
              'Nombre de Usuario',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Bio breve del usuario, descripción o rol.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
