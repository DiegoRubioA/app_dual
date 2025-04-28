import 'package:flutter/material.dart';

class Carfeed extends StatefulWidget {
  const Carfeed({super.key, required this.card, this.onTap});

  final Map<String, String> card;
  final VoidCallback? onTap;

  @override
  State<Carfeed> createState() => _CarfeedState();
}

class _CarfeedState extends State<Carfeed> {
  bool _liked = false;
  int _likesCount = 0;

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      color: Colors.pink,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(child: Text(widget.card['name']![0])),
              title: Text(widget.card['name']!),
              subtitle: Text(widget.card['description']!),
            ),
            Hero(
              tag: 'post-image-${widget.card['name']}',
              child: SizedBox(
                height: 200,
                width: double.infinity,
                child: Image.network(
                  widget.card['image']!,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, prog) {
                    if (prog == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                  errorBuilder:
                      (_, __, ___) => const Center(child: Icon(Icons.error)),
                ),
              ),
            ),
            OverflowBar(
              alignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _liked = !_liked;
                      _liked ? _likesCount++ : _likesCount--;
                    });
                  },
                  icon: Icon(
                    _liked ? Icons.favorite : Icons.favorite_border,
                    color: _liked ? Colors.red : Colors.pink,
                  ),
                  label: Text('$_likesCount', style: textStyle),
                ),
                TextButton(
                  onPressed: () {
                    // podrías abrir sección de comentarios
                  },
                  child: const Text("Comentar", style: textStyle),
                ),
                TextButton(
                  onPressed: () {
                    // compartir...
                  },
                  child: const Text("Compartir", style: textStyle),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
