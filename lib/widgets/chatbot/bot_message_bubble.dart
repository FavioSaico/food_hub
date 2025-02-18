import 'package:flutter/material.dart';
import 'package:food_hub/domain/message_chatbot.dart';

class BotMessageBubble extends StatelessWidget {
  final Message message;

  const BotMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // para que los mensajes aparezcan del otro lado
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 218, 218, 218), 
            borderRadius: BorderRadius.circular(20)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              message.text, // Agregamos el texto del mensaje
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ),
        // const SizedBox(height: 5),
        // imagen del perfil
        // _ImageBubble(message.imageUrl!),
        const SizedBox(height: 10),
      ],
    );
  }
}

// widget privado para mostrar la imagen
class _ImageBubble extends StatelessWidget {

  final String imageUrl;

  const _ImageBubble(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    // obtenemos las dimensiones del dispositivo
    // MediaQuery tiene info del dispositivo, context es el lugar donde la  MediaQuery es buscada
    // size es una propiedad de MediaQuery
    final size = MediaQuery.of(context).size; 

    return ClipRRect( // ClipRRect es un widget que permite los bordes redondeados
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          imageUrl,
          width: size.width * 0.7, // 70% del ancho de la pantalla
          height: 150,
          fit: BoxFit.cover, // estira la imagen, manteniendo proporcionalidad para que cubra todo el ClipRRect
          // se consturye en tiempo de ejecución. loadingProgress indica el % de carga
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child; // cuando ya se cargo se regresa el child que es la imagen gif
            // mientras carga mostrará este container
            return Container(
              width: size.width * 0.7, 
              height: 150,
              padding: const EdgeInsets.symmetric( horizontal: 10, vertical: 5),
              child: const Text('Mi amor está enviando una imagen'),
            );
          },
        ));
  }
}