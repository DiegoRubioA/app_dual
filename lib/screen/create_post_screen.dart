// lib/screen/create_post_screen.dart

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  String _title = '', _body = '';
  File? _pickedImage;

  Future<void> _pickImage() async {
    final XFile? img = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 600,
      imageQuality: 80,
    );
    if (img != null) {
      setState(() {
        _pickedImage = File(img.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Publicación'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // TÍTULO
              TextFormField(
                decoration: const InputDecoration(labelText: 'Título'),
                onSaved: (val) => _title = val?.trim() ?? '',
                validator:
                    (val) =>
                        val == null || val.trim().isEmpty ? 'Requerido' : null,
              ),
              const SizedBox(height: 12),
              // CONTENIDO
              TextFormField(
                decoration: const InputDecoration(labelText: 'Contenido'),
                maxLines: 4,
                onSaved: (val) => _body = val?.trim() ?? '',
                validator:
                    (val) =>
                        val == null || val.trim().isEmpty ? 'Requerido' : null,
              ),
              const SizedBox(height: 20),
              // PREVIEW / PLACEHOLDER
              Container(
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child:
                    _pickedImage != null
                        ? Image.file(_pickedImage!, fit: BoxFit.cover)
                        : const Center(
                          child: Text('No has seleccionado imagen'),
                        ),
              ),
              const SizedBox(height: 8),
              // BOTÓN PARA SELECCIONAR
              ElevatedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.photo_library),
                label: const Text('Seleccionar Imagen'),
              ),
              const SizedBox(height: 24),
              // PUBLICAR
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (_pickedImage == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Por favor selecciona una imagen.'),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                      return;
                    }
                    _formKey.currentState!.save();
                    // Devuelve un Map con la ruta local de la imagen:
                    Navigator.pop<Map<String, String>>(context, {
                      'name': _title,
                      'description': _body,
                      'image': _pickedImage!.path,
                    });
                  }
                },
                child: const Text('Publicar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
