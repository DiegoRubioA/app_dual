// lib/screen/details_screen.dart

import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args == null || args is! Map<String, String>) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(
          child: Text('No se recibieron datos de la publicación'),
        ),
      );
    }

    final card = args;
    final name = card['name'] ?? 'Sin título';
    final description = card['description'] ?? 'Sin descripción';
    final imageUrl = card['image'] ?? '';

    return Scaffold(
      appBar: AppBar(title: Text(name), backgroundColor: Colors.blue),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imageUrl.isNotEmpty)
              Hero(
                tag: 'post-image-$name',
                child: Image.network(
                  imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (ctx, child, progress) {
                    if (progress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                  errorBuilder:
                      (ctx, err, stack) =>
                          const Center(child: Icon(Icons.error)),
                ),
              ),
            const SizedBox(height: 16),
            Text(description, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 24),
            const Text(
              'Aquí podrías añadir más detalles, comentarios, etc.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
