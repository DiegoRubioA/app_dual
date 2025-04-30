// ignore: file_names
import 'package:flutter/material.dart';
import 'package:app_dual/core/constants/colors.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

// Importaciones:
// - `colors.dart`: paleta de colores personalizada (color principal).
// - `image_picker`: para seleccionar una imagen desde la galería.
// - `dart:io`: necesario para manejar imágenes como archivos locales.

/// Pantalla para editar el perfil del usuario.
/// Permite cambiar nombre, usuario, biografía e imagen de perfil.
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controladores con valores iniciales
  final _nameController = TextEditingController(text: 'Diego');
  final _usernameController = TextEditingController(text: '@Diego_Rubio');
  final _bioController = TextEditingController(
    text: 'Desarrollador Flutter | UX Lover | Café + Código ☕',
  );

  File? _selectedImage; // Imagen de perfil seleccionada
  bool _isPickingImage = false;

  /// Permite seleccionar una imagen desde la galería del dispositivo
  Future<void> _pickImage() async {
    if (_isPickingImage) return;

    setState(() => _isPickingImage = true);

    try {
      final picker = ImagePicker();
      final image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      debugPrint('Error al seleccionar imagen: $e');
    } finally {
      setState(() => _isPickingImage = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Perfil'),
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Avatar con botón para cambiar imagen
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          _selectedImage != null
                              ? FileImage(_selectedImage!)
                              : const AssetImage('assets/images/fotoPerfil.jpg')
                                  as ImageProvider,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 18,
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt, size: 18),
                        onPressed: _pickImage,
                        tooltip: 'Cambiar foto',
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Campo de nombre
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre completo'),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Este campo es obligatorio'
                            : null,
              ),

              const SizedBox(height: 16),

              // Campo de nombre de usuario
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre de usuario',
                ),
              ),

              const SizedBox(height: 16),

              // Campo de biografía
              TextFormField(
                controller: _bioController,
                maxLines: 3,
                decoration: const InputDecoration(labelText: 'Biografía'),
              ),

              const SizedBox(height: 30),

              // Botón para guardar cambios
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Aquí se podrían guardar los datos modificados
                    Navigator.pop(context);
                  }
                },
                child: const Text('Guardar cambios'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
