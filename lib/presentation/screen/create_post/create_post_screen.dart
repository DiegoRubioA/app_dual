import 'package:flutter/material.dart';
import '../../../l10n/l10n.dart'; // Ajusta si tu estructura de carpetas es distinta

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context)!.createPost),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: S.of(context)!.title),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(labelText: S.of(context)!.content),
            ),
            const SizedBox(height: 16),
            Container(
              height: 150,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(S.of(context)!.noImageSelected),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.image),
              label: Text(S.of(context)!.selectImage),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              child: Text(S.of(context)!.publish),
            ),
          ],
        ),
      ),
    );
  }
}
