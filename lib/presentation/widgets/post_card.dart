import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:app_dual/l10n/l10n.dart';
import 'package:share_plus/share_plus.dart';

class PostCard extends StatefulWidget {
  final Map<String, String> data;
  final VoidCallback onTap;

  const PostCard({required this.data, required this.onTap, super.key});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late int likes;
  bool isLiked = false;
  bool _showDescription = false;

  @override
  void initState() {
    super.initState();
    likes = int.tryParse(widget.data['likes'] ?? '0') ?? 0;
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
      likes += isLiked ? 1 : -1;
    });
  }

  void sharePost() {
    final author = widget.data['author'] ?? '';
    final message = widget.data['message'] ?? '';
    final shareText = 'Publicación de $author:\n\n$message';

    SharePlus.instance.share(ShareParams(text: shareText));
  }

  Widget buildImage() {
    final url = widget.data['imageUrl'];
    final colors = Theme.of(context).colorScheme;

    if (url == null || url.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    if (url.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: url,
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
      );
    }

    if (File(url).existsSync()) {
      return Image.file(File(url), height: 180, fit: BoxFit.cover);
    }

    // NUEVO: tratar como asset si es una ruta relativa
    return Image.asset(url, height: 180, fit: BoxFit.cover);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: widget.onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  CircleAvatar(child: Text(widget.data['author']![0])),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      widget.data['author']!,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ],
              ),
            ),

            // Imagen
            Hero(tag: widget.data['id']!, child: buildImage()),

            // Descripción visible si está expandida
            if (_showDescription)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Text(widget.data['message'] ?? ''),
              ),

            // Botones
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _ActionButton(
                    icon: isLiked ? Icons.favorite : Icons.favorite_border,
                    label: '$likes',
                    color: isLiked ? Colors.red : colors.primary,
                    onPressed: toggleLike,
                  ),
                  _ActionButton(
                    icon: Icons.comment,
                    label:
                        _showDescription
                            ? S.of(context)!.hideContent
                            : S.of(context)!.content,
                    color: colors.primary,
                    onPressed: () {
                      setState(() => _showDescription = !_showDescription);
                    },
                  ),
                  _ActionButton(
                    icon: Icons.share,
                    label: S.of(context)!.share,
                    color: colors.primary,
                    onPressed: sharePost,
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
