import 'package:flutter/material.dart';
import 'package:food_hub/config/env.dart';
import 'package:food_hub/domain/message_chatbot.dart';
import 'package:dio/dio.dart';
import 'package:food_hub/domain/stack_response.dart';

// CLASE PARA REALIZAR LA PETICIÖN
class GetAnswerStackIA {
  final _dio = Dio(BaseOptions(
    baseUrl: 'https://api.stack-ai.com/inference/v0/run',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${Environment.apiKey}'
    },
    connectTimeout: Duration(seconds: 180),
    receiveTimeout: Duration(seconds: 180)
  ));

  Future<Message> getAnswer(String input) async {

    final Map<String, dynamic> body = {
      "in-0": input,
    };

    final response = await _dio.post('/${Environment.orgId}/${Environment.tabId}',
      data: body
    );

    final responseStack = StackAIResponse.fromJsonMap(response.data); // mapeamos la respuesta
    return responseStack.toMessageEntity(); // retornamos una instancia de Message
  }
}

class ChatbotProvider extends ChangeNotifier {
  // para el manejo del scroll de in widget
  final ScrollController chatScrollController = ScrollController();
  final getAnswer = GetAnswerStackIA(); // clase con las peticiones

  // guardaremos la lista de mensajes
  List<Message> messageList = [
    Message(text: 'Hola, soy un bot', fromWho: FromWho.bot),
  ];

  // añadimos el mensaje a la lista
  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return; // si el mensaje esta vacio

    // construimos con la clase Mensaje
    final newMessage = Message(text: text, fromWho: FromWho.me);
    messageList.add(newMessage); // se agrega a la lista

    final newMessageLoad = Message(text: "load", fromWho: FromWho.bot);
    messageList.add(newMessageLoad);

    herReply(text); // sin await, para que no realice una espera

    notifyListeners();
    moveScrollToBottom(); // cambiamos la posición del scroll
  }

  // la respuesta de del bot
  Future<void> herReply(String text) async {
    
    final botMessage = await getAnswer.getAnswer(text); // obtenemos el mensaje
    // await Future.delayed( const Duration(seconds: 2));
    messageList.removeLast();

    // final botMessage = Message(text: "Mensaje por defecto", fromWho: FromWho.bot);
    // messageList.add(herMessage); // lo sumamos a la lista
    messageList.add(botMessage);

    notifyListeners(); // notificamos el cambio en la lista de mensajes
    moveScrollToBottom(); // movemos el scroll
  }

  Future<void> moveScrollToBottom() async {

    await Future.delayed(const Duration(milliseconds: 100));

    // realizamos una animación para el scroll mediante el controller
    chatScrollController.animateTo(
      chatScrollController.position.maxScrollExtent, // movemos la posición del scroll, siempre al final o maximo
      duration: const Duration(milliseconds: 300), // duración
      curve: Curves.easeOut // tipo de animación
    );
  }
}
