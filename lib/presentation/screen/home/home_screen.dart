import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:app_dual/data/data.dart';
import 'package:app_dual/presentation/widgets/post_card.dart';
import 'package:app_dual/presentation/widgets/post_search.dart';
import 'package:app_dual/l10n/l10n.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar con búsqueda y título internacionalizado
      appBar: AppBar(
        title: Text(S.of(context)!.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final navigator = Navigator.of(context); // ✅ evitar warning

              final result = await showSearch<Map<String, dynamic>>(
                context: context,
                delegate: PostSearchDelegate(listCard),
              );

              if (result != null && result.isNotEmpty) {
                navigator.pushNamed('/details', arguments: result);
              }
            },
          ),
        ],
      ),

      // Drawer de navegación
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

      // Feed de posts
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

      // Botón FAB que añade una publicación nueva
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newPost = await Navigator.pushNamed(context, '/create');
          if (newPost != null && newPost is Map<String, dynamic>) {
            setState(() {
              listCard.insert(0, newPost);
              nextId = newPost['id'] + 1;
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
