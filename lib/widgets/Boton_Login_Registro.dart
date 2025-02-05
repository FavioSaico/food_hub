import 'package:flutter/material.dart';
import 'package:food_hub/utils/colors.dart';

class AppClickableText extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;

  const AppClickableText({
    Key? key,
    required this.text,
    this.onPressed,
  }) : super(key: key);

  @override
  _AppClickableTextState createState() => _AppClickableTextState();
}

class _AppClickableTextState extends State<AppClickableText> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      onHighlightChanged: (isPressed) {
        setState(() {
          _isPressed = isPressed; // Cambia el estado cuando se mantiene presionado
        });
      },
      splashColor: AppColors.mainColor, // Color del efecto de splash
      highlightColor: AppColors.mainColor, // Fondo cuando se mantiene presionado
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
          color: _isPressed ? AppColors.btnSelectColor : AppColors.mainColor, // Fondo al presionar con btnSelectColor
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            widget.text,
            style: const TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold, // Texto en negrita
              color: Colors.white, // El texto será blanco
            ),
          ),
        ),
      ),
    );
  }
}