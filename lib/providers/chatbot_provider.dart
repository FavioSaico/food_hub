import 'package:flutter/material.dart';
import 'package:food_hub/domain/message_chatbot.dart';
import 'package:dio/dio.dart';

// Mensaje del BOT
class GetYesNoAnswer {
  final _dio = Dio();

  Future<Message> getAnswer() async {
    final response = await _dio.get('https://yesno.wtf/api');

    final yesNoModel = YesNoModel.fromJsonMap(response.data); // mapeamos la respuesta
    return yesNoModel.toMessageEntity(); // toMessageEntity es el mapper
    // retornamos una instancia de Message, que se añadirá a la lista
  }
}

// ChangeNotifier permite que el provider pueda notificar a sus subcriptores de los cambios de estado
class ChatbotProvider extends ChangeNotifier {
  // creamos una instancia del scroll controller, para el manejo del scroll de in widget
  final ScrollController chatScrollController = ScrollController();
  final getYesNoAnswer = GetYesNoAnswer(); // clase con las peticiones

  // guardaremos la lista de mensajes
  List<Message> messageList = [
    Message(text: 'Hola, soy un bot', fromWho: FromWho.bot),
  ];

  // metodo de envio de mensajes
  // añadimos el mensaje a la lista
  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return; // si el mensaje esta vacio

    // construimos con la clase Mensaje
    final newMessage = Message(text: text, fromWho: FromWho.me);
    messageList.add(newMessage); // se agrega a la lista

    // if (text.endsWith('?')) { // si el mensaje termina en ?, entonces se hace la petición
    //   herReply();
    // }
    herReply();

    notifyListeners(); // avisa o notifica que el provider cambio a los que estan escuchando sus cambios
    moveScrollToBottom(); // cambiamos la posición del scroll mediante el controller al enviarse el mensaje
  }

  // la respuesta de del bot
  Future<void> herReply() async {
    // final herMessage = await getYesNoAnswer.getAnswer(); // obtenemos el mensaje
    Future.delayed( const Duration(seconds: 1));
    final herMessage = Message(text: "Mensaje por defecto", fromWho: FromWho.bot);

    messageList.add(herMessage); // lo sumamos a la lista


    notifyListeners(); // notificamos el cambio en la lista de mensajes
    moveScrollToBottom(); // movemos el scroll
  }

  Future<void> moveScrollToBottom() async {
    // esperamos por 0.1 segundos, para hacer la animación de forma más lenta
    await Future.delayed(const Duration(milliseconds: 100));

    // realizamos una animación para el scroll mediante el controller
    chatScrollController.animateTo(
      chatScrollController.position.maxScrollExtent, // movemos la posición del scroll, siempre al final o maximo
      duration: const Duration(milliseconds: 300), // duración
      curve: Curves.easeOut // tipo de animación
    );
  }
}

// Modelo de la petición
class YesNoModel {
  YesNoModel({
    required this.answer,
    required this.forced,
  });

  final String answer;
  final bool forced;

  // factory para crear una nueva instancia de la clase recibien el map de la respuesta de la api
  factory YesNoModel.fromJsonMap(Map<String, dynamic> json) => YesNoModel(
        answer: json["answer"],
        forced: json["forced"],
  );

  // retorno de un Map
  Map<String, dynamic> toJson() => {
        "answer": answer,
        "forced": forced,
      };
  
  // Creamos este mapper para retorna un message
  Message toMessageEntity() => Message(
    text: answer == 'yes' ? 'Si' : 'No', 
    fromWho: FromWho.bot,
  );
}