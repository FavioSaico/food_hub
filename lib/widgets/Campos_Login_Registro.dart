import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;

  const AppTextField({
    Key? key,
    required this.hintText,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(fontStyle: FontStyle.italic),
          border: InputBorder.none,
          suffixIcon: Icon(icon, color: Colors.teal), // Ícono al lado derecho
        ),
      ),
    );
  }
}