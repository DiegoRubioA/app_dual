/// Lista simulada de publicaciones que podrían representar un feed de una red social.
/// Cada elemento es un mapa con los campos: id, name, description e image.
List<Map<String, dynamic>> listCard = [
  {
    "id": 1,
    "name": "Pedro García Lopez",
    "description":
        "Hoy me encontré con esta impresionante imagen retro que me recuerda cómo la fotografía capturaba momentos con alma. La textura, el color y el enfoque son simplemente perfectos. 📸✨",
    "image": "assets/images/publicacion1.jpg",
  },
  {
    "id": 2,
    "name": "Raúl Jimeno",
    "description":
        "Esta ave tropical me dejó sin palabras. Sus plumas parecen pintadas a mano por la naturaleza. Los colores son tan intensos que cuesta creer que no haya sido editada. Un verdadero espectáculo visual. 🦜🌈",
    "image": "assets/images/publicacion2.jpg",
  },
];

/// Variable global para mantener el ID siguiente disponible al crear una nueva publicación.
/// Útil si se implementa una función para agregar elementos dinámicamente a `listCard`.
int nextId = 3;
