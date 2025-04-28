import 'package:flutter/material.dart';

class PostSearchDelegate extends SearchDelegate<Map<String, String>> {
  final List<Map<String, String>> posts;
  PostSearchDelegate(this.posts);

  @override
  List<Widget>? buildActions(BuildContext context) => [
    if (query.isNotEmpty)
      IconButton(icon: const Icon(Icons.clear), onPressed: () => query = ''),
  ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () => close(context, {}),
  );

  @override
  Widget buildResults(BuildContext context) {
    final results =
        posts
            .where(
              (p) => p['name']!.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
    return _buildList(context, results);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions =
        posts
            .where(
              (p) => p['name']!.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
    return _buildList(context, suggestions);
  }

  Widget _buildList(BuildContext context, List<Map<String, String>> list) {
    if (list.isEmpty) {
      return const Center(child: Text('No se encontraron resultados'));
    }
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (_, i) {
        final item = list[i];
        return ListTile(
          leading: CircleAvatar(child: Text(item['name']![0])),
          title: Text(item['name']!),
          onTap: () {
            close(context, item);
            Navigator.pushNamed(context, '/details', arguments: item);
          },
        );
      },
    );
  }
}
