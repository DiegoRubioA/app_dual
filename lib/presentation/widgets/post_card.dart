import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:app_dual/l10n/l10n.dart';

class PostCard extends StatelessWidget {
  final Map<String, String> data;
  final VoidCallback onTap;

  const PostCard({required this.data, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Encabezado: avatar + autor
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  CircleAvatar(child: Text(data['author']![0])),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      data['author']!,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ],
              ),
            ),

            // Imagen con placeholder y Hero
            Hero(
              tag: data['id']!,
              child: CachedNetworkImage(
                imageUrl: data['imageUrl']!,
                height: 180,
                fit: BoxFit.cover,
                placeholder:
                    (_, __) => Container(
                      height: 180,
                      color: colors.surfaceContainerHighest,
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                errorWidget:
                    (_, __, ___) => Container(
                      height: 180,
                      color: colors.errorContainer,
                      child: const Center(child: Icon(Icons.broken_image)),
                    ),
              ),
            ),

            // Acciones (likes, comentar, compartir)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _ActionButton(
                    icon: Icons.favorite_border,
                    label: data['likes']!,
                    color: colors.primary,
                    onPressed: () {},
                  ),
                  _ActionButton(
                    icon: Icons.comment,
                    label: S.of(context)!.content,
                    color: colors.primary,
                    onPressed: () {},
                  ),
                  _ActionButton(
                    icon: Icons.share,
                    label: S.of(context)!.share,
                    color: colors.primary,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(foregroundColor: color),
      onPressed: onPressed,
      icon: Icon(icon, size: 20),
      label: Text(label),
    );
  }
}
