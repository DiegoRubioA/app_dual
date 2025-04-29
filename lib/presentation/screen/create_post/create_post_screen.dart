// lib/presentation/screen/create/create_post_screen.dart

import 'package:flutter/material.dart';
import 'package:app_dual/data/data.dart'; // para usar listCard y nextId

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _descCtrl = TextEditingController();
  final TextEditingController _imageCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Crear Publicación')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Campo: Nombre
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  hintText: 'Ingresa el nombre o título',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nombre requerido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Campo: Descripción
              TextFormField(
                controller: _descCtrl,
                decoration: const InputDecoration(
                  labelText: 'Descripción',
                  hintText: 'Ingresa una descripción',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Descripción requerida';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Campo: URL de Imagen (opcional)
              TextFormField(
                controller: _imageCtrl,
                decoration: const InputDecoration(
                  labelText: 'Imagen (URL)',
                  hintText: 'URL de imagen opcional',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  // Campo opcional: si no está vacío, validamos que parezca una URL
                  if (value != null && value.isNotEmpty) {
                    final uri = Uri.tryParse(value);
                    if (uri == null || !(uri.isAbsolute)) {
                      return 'URL inválida';
                    }
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              // Botón: Crear publicación
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text('Crear publicación'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Crear el nuevo post con ID único
                      final newPost = {
                        "id": nextId,
                        "name": _nameCtrl.text.trim(),
                        "description": _descCtrl.text.trim(),
                        "image": _imageCtrl.text.trim(),
                      };
                      nextId++; // actualizar para la próxima publicación nueva
                      // Retornar el nuevo post a la pantalla anterior (Home)
                      Navigator.pop(context, newPost);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
