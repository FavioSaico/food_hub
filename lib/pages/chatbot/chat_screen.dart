import 'package:flutter/material.dart';
import 'package:food_hub/domain/message_chatbot.dart';
import 'package:food_hub/providers/chatbot_provider.dart';
import 'package:food_hub/utils/colors.dart';
import 'package:food_hub/widgets/app_menu.dart';
import 'package:food_hub/widgets/chatbot/my_message_bubble.dart';
import 'package:food_hub/widgets/chatbot/bot_message_bubble.dart';
import 'package:food_hub/widgets/chatbot/message_field_box.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Row(
          children: [
            SizedBox(width: 10,),
            CircleAvatar(
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.white,
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.mainColor,
                ),
                icon: Icon(Icons.chevron_left, size: 25,)
              ),
            ),
          ],
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.mainColor,
              child: Icon(Icons.smart_toy, color: Colors.white,size: 30,),
            ),
            SizedBox(width: 10,),
            const Text('Chatbot'),
          ],
        ),
      ),
        // centerTitle: false, // por defecto ya es false
      // el cuerpo de la aplicación, lo anterior fue la cabecera
      body: _ChatView(),
      bottomNavigationBar: AppMenu(),
    );
  }
}

class _ChatView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    // busca el provider o la instancia del ChatProvider
    final chatProvider = context.watch<ChatbotProvider>();

    return SafeArea( 
      // widget de Area Segura, que coloca los hijos dentro de un area generando margen para los botones inferiores del telefono
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10), // symmetric genera padding a nivel horizontal o vertical
        child: Column( // colum para podemos la lista de mensajes y el input de mensaje un debajo de otro
          children: [
            SizedBox(height: 5,),
            Expanded( // coloca a su hijo en todo el espacio disponible que el padre le de
              child: ListView.builder( // builder: construye en tiempo de ejecución a medida que aparecen en la pantalla, es mejor para listas largas
                  controller: chatProvider.chatScrollController, // es ScrollControler que va a controlar es scroll del elemento, pasamos la variable del provider
                  itemCount: chatProvider.messageList.length, // indicamos la cantidad de elementos a crear
                  // método obligatorio, recibe el context que es BuildContext(arbol de widget) e index e indice
                  itemBuilder: (context, index) {
                    // obtenemos el mensaje en base al indice y la lista  
                    final message = chatProvider.messageList[index];

                    return (message.fromWho == FromWho.bot)
                      ? BotMessageBubble(message: message) // si es de ella
                      : MyMessageBubble(message: message); // si es nuestro mensaje
                })
            ),
            MessageFieldBox(
              // pasamos el método que ejecutará la caja de texto para enviar el mensaje
              onValue: (value) => chatProvider.sendMessage(value), // forma resumida, el value se pasar por defecto a la función
              // onValue: chatProvider.sendMessage,
            ),
            SizedBox(height: 5,)
          ],
        ),
      ),
    );
  }
}