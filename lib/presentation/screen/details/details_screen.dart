// lib/presentation/screen/details/details_screen.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // nueva importación para persistencia

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  List<String> _comments = [];
  final TextEditingController _commentController = TextEditingController();
  bool _loadingComments = true;
  bool _submittingComment = false;
  late int postId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Obtener argumentos de la ruta (datos de la publicación)
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args == null || args is! Map<String, dynamic>) {
      // Si no hay datos, mostrar pantalla de error
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pop(context);
      });
      return;
    }
    final card = args;
    postId = card["id"] ?? -1;
    // Cargar comentarios almacenados para esta publicación
    _loadComments();
  }

  Future<void> _loadComments() async {
    final prefs = await SharedPreferences.getInstance();
    final storedComments = prefs.getStringList('comments_$postId');
    setState(() {
      _comments = storedComments ?? [];
      _loadingComments = false;
    });
  }

  Future<void> _addComment() async {
    final text = _commentController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _submittingComment = true;
    });
    // Simular un breve tiempo de envío (p. ej., espera de respuesta de red)
    await Future.delayed(const Duration(milliseconds: 500));
    // Añadir el comentario a la lista local
    setState(() {
      _comments.add(text);
      _submittingComment = false;
    });
    _commentController.clear();
    // Guardar la lista actualizada de comentarios en persistencia local
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('comments_$postId', _comments);
  }

  @override
  Widget build(BuildContext context) {
    if (_loadingComments) {
      // Mostrar indicador de carga mientras se cargan comentarios
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // Ya se cargaron los comentarios, continuamos construyendo la UI
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final name = args['name'] ?? 'Sin título';
    final description = args['description'] ?? 'Sin descripción';
    final imageUrl = args['image'] ?? '';

    return Scaffold(
      appBar: AppBar(title: Text(name), backgroundColor: Colors.blue),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen de la publicación (con hero animation)
            if (imageUrl.isNotEmpty)
              Hero(
                tag: 'post-image-$name',
                child: Image.network(
                  imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                  errorBuilder:
                      (_, __, ___) => const Center(child: Icon(Icons.error)),
                ),
              ),
            if (imageUrl.isNotEmpty) const SizedBox(height: 16),
            // Descripción de la publicación
            Text(description, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 24),
            // Sección de comentarios
            const Text(
              'Comentarios:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (_comments.isEmpty)
              const Text(
                'No hay comentarios aún.',
                style: TextStyle(color: Colors.grey),
              ),
            // Lista de comentarios existentes
            for (final comment in _comments)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text("• $comment"),
              ),
            const SizedBox(height: 16),
            // Campo de texto para nuevo comentario y botón de enviar
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    maxLines: 2,
                    decoration: const InputDecoration(
                      hintText: 'Escribe un comentario',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _submittingComment ? null : _addComment,
                  child:
                      _submittingComment
                          ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                          : const Text('Enviar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
