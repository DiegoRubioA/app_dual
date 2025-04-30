# App Dual

Aplicación Flutter creada como proyecto universitario. Simula una red social con funcionalidad offline, personalización de tema e idioma, y un diseño modular.

---

## 📲 Características

- 📝 Crear y visualizar publicaciones
- 🗣️ Comentarios persistentes por publicación
- 🧑‍🎨 Perfil editable con imagen, nombre y biografía
- 🌙 Modo oscuro / claro / automático
- 🌐 Soporte multilenguaje (es, en, fr, it, de)
- 🔍 Búsqueda por autor
- 📤 Compartir publicaciones

---

## 🧠 Tecnologías utilizadas

- Flutter 3.x
- Dart
- Riverpod (gestión de estado)
- SharedPreferences (almacenamiento local)
- Image Picker (selector de imágenes)
- Share Plus (compartir publicaciones)
- Cached Network Image (para imágenes remotas con caché)

---

## 📁 Estructura del proyecto

lib/ 
├── core/ # Temas, colores y configuración 
│ ├── constants/ # Colores, constantes generales 
│ ├── theme/ # Definición de temas
├── data/ # Datos simulados (sin backend) 
├── l10n/ # Archivos de localización 
├── presentation/ 
│ ├── providers/ # Providers (idioma, tema) 
│ ├── screen/ # Pantallas principales 
│ └── widgets/ # Componentes reutilizables
├── app.dart # Widget principal de la aplicación 
└── main.dart # Punto de entrada
---

## ▶️ Cómo ejecutar el proyecto

```bash
flutter pub get
flutter run