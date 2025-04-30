import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:app_dual/data/data.dart';

// Importaciones:
// - `material.dart`: para construir la interfaz.
// - `dart:io`: para manipular archivos locales (como imágenes).
// - `image_picker`: para seleccionar imágenes desde la galería.
// - `data.dart`: acceso a la lista de publicaciones y el id incremental.

/// Pantalla para crear una nueva publicación.
/// Permite ingresar nombre, descripción y seleccionar una imagen desde la galería.
class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _formKey = GlobalKey<FormState>(); // Llave para validar el formulario.
  final _nameCtrl = TextEditingController(); // Controlador del campo de nombre.
  final _descCtrl =
      TextEditingController(); // Controlador del campo de descripción.
  File? _pickedImage; // Imagen seleccionada por el usuario.
  bool _isPicking = false; // Para evitar múltiples llamadas al selector.

  /// Abre el selector de imágenes y guarda la imagen elegida.
  Future<void> _pickImage() async {
    if (_isPicking) return;
    setState(() => _isPicking = true);

    try {
      final picker = ImagePicker();
      final file = await picker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        setState(() => _pickedImage = File(file.path));
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    } finally {
      setState(() => _isPicking = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Crear Publicación')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Campo de nombre
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  hintText: '¿Quién publica?',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator:
                    (value) =>
                        value == null || value.trim().isEmpty
                            ? 'Campo obligatorio'
                            : null,
              ),
              const SizedBox(height: 16),

              // Campo de descripción
              TextFormField(
                controller: _descCtrl,
                decoration: const InputDecoration(
                  labelText: 'Descripción',
                  hintText: '¿Qué quieres compartir?',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                ),
                maxLines: 3,
                validator:
                    (value) =>
                        value == null || value.trim().isEmpty
                            ? 'Campo obligatorio'
                            : null,
              ),
              const SizedBox(height: 16),

              // Sección para mostrar imagen seleccionada y botón de selector
              Row(
                children: [
                  Expanded(
                    child:
                        _pickedImage != null
                            ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                _pickedImage!,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                            )
                            : const Text('Ninguna imagen seleccionada'),
                  ),
                  const SizedBox(width: 12),
                  IconButton(
                    icon: const Icon(Icons.image),
                    onPressed: _isPicking ? null : _pickImage,
                    tooltip: _isPicking ? 'Cargando...' : 'Seleccionar imagen',
                  ),
                ],
              ),

              const Spacer(),

              // Botón para crear la publicación
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  icon: const Icon(Icons.publish),
                  label: const Text('Crear publicación'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final post = {
                        'id': nextId,
                        'name': _nameCtrl.text.trim(),
                        'description': _descCtrl.text.trim(),
                        'image': _pickedImage?.path ?? '',
                      };
                      nextId++;
                      Navigator.pop(context, post); // Retorna el nuevo post.
                    }
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: colors.primary,
                    foregroundColor: colors.onPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
