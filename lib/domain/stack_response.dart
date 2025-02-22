
// Modelo de la petición
import 'package:food_hub/domain/message_chatbot.dart';

class StackAIResponse {
  StackAIResponse({
    required this.shortResponse,
    required this.largeResponse,
  });

  final String shortResponse;
  final String largeResponse;

  // factory para crear una nueva instancia de la clase recibien el map de la respuesta de la api
  factory StackAIResponse.fromJsonMap(Map<String, dynamic> json) => StackAIResponse(
        shortResponse: json["outputs"]["out-0"] ?? "Mensaje por defecto",
        largeResponse: json["outputs"]["out-1"] ?? "Mensaje largo por defecto",
  );

  // retorno de un Map
  Map<String, dynamic> toJson() => {
        "answer": shortResponse,
        "forced": largeResponse,
      };
  
  // Creamos este mapper para retorna un message
  Message toMessageEntity() => Message(
    text: shortResponse, 
    fromWho: FromWho.bot,
  );
}