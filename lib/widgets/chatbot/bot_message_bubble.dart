import 'package:flutter/material.dart';
import 'package:food_hub/domain/message_chatbot.dart';

class BotMessageBubble extends StatelessWidget {
  final Message message;

  const BotMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // para que los mensajes aparezcan del otro lado
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 233, 233, 233), 
            borderRadius: BorderRadius.circular(20)
          ),
          child: message.text == "load" 
            ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Image.asset('assets/imagenes/typing-loading.gif', width: 30, height: 30),
            )
            : ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: size.width * 0.7, // 🔹 Máximo ancho de 300px
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  message.text.replaceAll('*', ''), // Agregamos el texto del mensaje
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
