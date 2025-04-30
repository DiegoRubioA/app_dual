import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:app_dual/data/data.dart';
import 'package:app_dual/presentation/widgets/post_card.dart';
import 'package:app_dual/presentation/widgets/post_search.dart';
import 'package:app_dual/l10n/l10n.dart';

// Importaciones:
// - `data.dart`: para acceder a la lista de publicaciones (`listCard`).
// - `post_card.dart`: widget que muestra cada publicación.
// - `post_search.dart`: lógica personalizada de búsqueda.
// - `l10n.dart`: para internacionalización con `S.of(context)`.

/// Pantalla principal que muestra el feed de publicaciones.
/// Incluye navegación, búsqueda, y creación de nuevas publicaciones.
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar con botón de búsqueda y título traducido.
      appBar: AppBar(
        title: Text(S.of(context)!.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final navigator = Navigator.of(context); // 🧼 Para evitar warning

              final result = await showSearch<Map<String, dynamic>>(
                context: context,
                delegate: PostSearchDelegate(
                  listCard,
                ), // Busca entre los posts.
              );

              // Si se seleccionó un resultado, navegar al detalle.
              if (result != null && result.isNotEmpty) {
                navigator.pushNamed('/details', arguments: result);
              }
            },
          ),
        ],
      ),

      // Drawer lateral de navegación entre pantallas
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: Text(
                S.of(context)!.appTitle,
                style: const TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: Text(S.of(context)!.home),
              onTap: () => Navigator.pushReplacementNamed(context, '/'),
            ),
            ListTile(
              leading: const Icon(Icons.create),
              title: Text(S.of(context)!.createPost),
              onTap: () => Navigator.pushNamed(context, '/create'),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: Text(S.of(context)!.profile),
              onTap: () => Navigator.pushNamed(context, '/profile'),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text(S.of(context)!.settingsTitle),
              onTap: () => Navigator.pushNamed(context, '/settings'),
            ),
          ],
        ),
      ),

      // Lista de publicaciones, usando PostCard personalizado.
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: listCard.length,
        itemBuilder: (context, index) {
          final post = listCard[index];
          return PostCard(
            data: {
              'id': '${post['id']}',
              'author': post['name']!,
              'message': post['description']!,
              'imageUrl': post['image']!,
              'likes': '0',
            },
            onTap: () {
              Navigator.pushNamed(context, '/details', arguments: post);
            },
          );
        },
      ),

      // Botón flotante para crear nueva publicación
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newPost = await Navigator.pushNamed(context, '/create');
          if (newPost != null && newPost is Map<String, dynamic>) {
            setState(() {
              listCard.insert(
                0,
                newPost,
              ); // Agrega la nueva publicación al inicio.
              nextId = newPost['id'] + 1;
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
