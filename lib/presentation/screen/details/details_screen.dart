import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Importaciones:
// - `dart:io`: para mostrar imágenes locales usando File.
// - `flutter/material.dart`: para la interfaz de usuario.
// - `shared_preferences`: para guardar y cargar comentarios localmente en el dispositivo.

/// Pantalla de detalles de una publicación.
/// Muestra una imagen, descripción y permite agregar comentarios.
class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  List<String> _comments = []; // Lista de comentarios almacenados.
  final TextEditingController _commentController = TextEditingController();
  bool _loadingComments = true;
  bool _submittingComment = false;
  late int postId;

  /// Se ejecuta cuando se detectan cambios en las dependencias del widget.
  /// Se extraen los argumentos de la ruta y se carga la lista de comentarios.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args == null || args is! Map<String, dynamic>) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pop(context); // Si no hay datos válidos, vuelve atrás.
      });
      return;
    }

    final card = args;
    postId =
        card["id"] is int
            ? card["id"]
            : int.tryParse(card["id"].toString()) ?? -1;

    _loadComments();
  }

  /// Carga los comentarios guardados localmente para esta publicación.
  Future<void> _loadComments() async {
    final prefs = await SharedPreferences.getInstance();
    final storedComments = prefs.getStringList('comments_$postId');
    setState(() {
      _comments = storedComments ?? [];
      _loadingComments = false;
    });
  }

  /// Agrega un comentario a la lista y lo guarda localmente.
  Future<void> _addComment() async {
    final text = _commentController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _submittingComment = true;
    });
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      _comments.add(text);
      _submittingComment = false;
    });
    _commentController.clear();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('comments_$postId', _comments);
  }

  @override
  Widget build(BuildContext context) {
    if (_loadingComments) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

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
            // Muestra imagen si está disponible
            if (imageUrl.isNotEmpty)
              Hero(
                tag: args['id'].toString(),
                child: Builder(
                  builder: (_) {
                    if (imageUrl.startsWith('http')) {
                      // Imagen desde internet
                      return Image.network(
                        imageUrl,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        errorBuilder:
                            (_, __, ___) =>
                                const Center(child: Icon(Icons.error)),
                      );
                    } else if (imageUrl.startsWith('/')) {
                      // Imagen local del dispositivo
                      return Image.file(
                        File(imageUrl),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      );
                    } else {
                      // Imagen desde assets
                      return Image.asset(
                        imageUrl,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      );
                    }
                  },
                ),
              ),

            if (imageUrl.isNotEmpty) const SizedBox(height: 16),

            // Descripción de la publicación
            Text(description, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 24),

            // Encabezado de comentarios
            const Text(
              'Comentarios:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Comentarios o mensaje de que no hay ninguno
            if (_comments.isEmpty)
              const Text(
                'No hay comentarios aún.',
                style: TextStyle(color: Colors.grey),
              ),

            for (final comment in _comments)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text("• $comment"),
              ),

            const SizedBox(height: 16),

            // Campo para escribir y enviar un nuevo comentario
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
