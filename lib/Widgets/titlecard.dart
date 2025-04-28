import 'package:flutter/material.dart';

class TitleCard extends StatelessWidget {
  const TitleCard({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(child: Text(name.isNotEmpty ? name[0] : "?")),
        const SizedBox(width: 10),
        Text(name),
        const SizedBox(width: 10),
        const Text(
          "Adios",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
