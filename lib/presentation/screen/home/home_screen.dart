import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:app_dual/data/data.dart';
import 'package:app_dual/presentation/widgets/post_card.dart';
import 'package:app_dual/l10n/l10n.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      // AppBar con título internacionalizado
      appBar: AppBar(title: Text(S.of(context)!.appTitle)),

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
              'id': '$index',
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

      // Botón FAB para crear nuevo post
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/create');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
