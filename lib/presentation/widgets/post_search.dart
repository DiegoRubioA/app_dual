import 'package:flutter/material.dart';

/// Delegate personalizado que implementa la lógica de búsqueda de publicaciones.
/// Hereda de `SearchDelegate` y devuelve un `Map<String, dynamic>` con los datos del resultado.
class PostSearchDelegate extends SearchDelegate<Map<String, dynamic>> {
  final List<Map<String, dynamic>> posts;

  PostSearchDelegate(
    this.posts,
  ); // Lista de publicaciones disponibles para buscar.

  /// Botones a la derecha del campo de búsqueda (acciones).
  @override
  List<Widget>? buildActions(BuildContext context) => [
    if (query.isNotEmpty)
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '', // Limpia el campo de búsqueda.
      ),
  ];

  /// Icono al inicio del campo de búsqueda (izquierda).
  @override
  Widget? buildLeading(BuildContext context) => IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () => close(context, {}), // Cierra el buscador.
  );

  /// Resultados cuando se pulsa "buscar" o Enter.
  @override
  Widget buildResults(BuildContext context) {
    final results =
        posts
            .where(
              (p) => (p['name'] ?? '').toString().toLowerCase().contains(
                query.toLowerCase(),
              ),
            )
            .toList();
    return _buildList(context, results);
  }

  /// Sugerencias en tiempo real mientras se escribe.
  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions =
        posts
            .where(
              (p) => (p['name'] ?? '').toString().toLowerCase().contains(
                query.toLowerCase(),
              ),
            )
            .toList();
    return _buildList(context, suggestions);
  }

  /// Construye la lista de resultados o sugerencias.
  Widget _buildList(BuildContext context, List<Map<String, dynamic>> list) {
    if (list.isEmpty) {
      return const Center(child: Text('No se encontraron resultados'));
    }

    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (_, i) {
        final item = list[i];
        return ListTile(
          leading: CircleAvatar(
            child: Text(item['name']![0]),
          ), // Inicial del autor
          title: Text(item['name']!),
          onTap: () {
            close(
              context,
              {},
            ); // Cierra el buscador sin devolver resultado directo
            Navigator.pushNamed(context, '/details', arguments: item);
          },
        );
      },
    );
  }
}
