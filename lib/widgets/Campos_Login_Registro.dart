import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool obscureText; // Añadir este parámetro
  // final ValueChanged<String> onValue;
  final TextEditingController textController;

  const AppTextField({
    super.key,
    required this.hintText,
    required this.icon,
    required this.textController,
    this.obscureText = false, // Por defecto, no ocultar el texto
  });

  @override
  Widget build(BuildContext context) {

    return TextField(
      controller: textController,
      obscureText: obscureText, // Aquí activamos la opción de ocultar el texto
      decoration: InputDecoration(
        labelText: hintText,
        hintStyle: const TextStyle(fontStyle: FontStyle.italic),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        suffixIcon: Icon(icon, color: Colors.teal), // Ícono al lado derecho
      ),
    );
  }
}