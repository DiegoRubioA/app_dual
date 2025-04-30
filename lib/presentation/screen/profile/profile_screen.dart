import 'package:flutter/material.dart';
import 'package:app_dual/core/constants/colors.dart';
import 'editProfileScreen.dart';

// Importaciones:
// - `colors.dart`: para aplicar colores personalizados (primario, secundario).
// - `editProfileScreen.dart`: pantalla para editar el perfil.

/// Pantalla que muestra la información del perfil del usuario.
/// Incluye avatar, nombre, biografía, estadísticas y botón para editar perfil.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar con título y botón de edición.
      appBar: AppBar(
        title: const Text('Mi Perfil'),
        backgroundColor: AppColors.primary,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditProfileScreen(),
                ),
              );
            },
          ),
        ],
      ),

      // Contenido principal desplazable
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Avatar de perfil con icono de cámara (decorativo)
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                const CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/images/fotoPerfil.jpg'),
                ),
                Positioned(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 18,
                    child: Icon(
                      Icons.camera_alt,
                      size: 20,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Nombre y nombre de usuario
            const Text(
              'Diego',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text('@Diego_Rubio', style: TextStyle(color: Colors.grey)),

            const SizedBox(height: 12),

            // Biografía
            const Text(
              'Desarrollador Flutter | UX Lover | Café + Código ☕',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 20),

            // Estadísticas del perfil (ficticias)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                _ProfileStat(title: 'Posts', count: 34),
                _ProfileStat(title: 'Seguidores', count: 120),
                _ProfileStat(title: 'Siguiendo', count: 89),
              ],
            ),

            const SizedBox(height: 30),

            // Botón de mensaje (acción decorativa por ahora)
            ElevatedButton.icon(
              icon: const Icon(Icons.message, color: Colors.white),
              label: const Text(
                "Enviar mensaje",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget reutilizable para mostrar una estadística del perfil.
class _ProfileStat extends StatelessWidget {
  final String title;
  final int count;

  const _ProfileStat({required this.title, required this.count});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$count',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(title),
      ],
    );
  }
}
