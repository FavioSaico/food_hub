import 'package:flutter/material.dart';
import 'package:food_hub/domain/message_chatbot.dart';
import 'package:food_hub/utils/colors.dart';

class MyMessageBubble extends StatelessWidget {
  final Message message;

  const MyMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end, // CrossAxis para column es el eje X, alinea a la derecha al final
      children: [
        Container( // el container es como un DiV, si no tiene contenido o dimensiones no se podrá ver
          decoration: BoxDecoration(
            color: AppColors.mainColor, 
            borderRadius: BorderRadius.circular(20)
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: size.width * 0.7, // 🔹 Máximo ancho de 300px
            ),
            // width: size.width * 0.7,
            child: Padding( // Padding no puede ser const porque el message.text se renderiza en tiempo de ejecución
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                message.text,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        const SizedBox(height: 5) // creamos un cajita para separar los containers
      ],
    );
  }
}