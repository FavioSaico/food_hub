import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_hub/domain/dio.dart';

class MessageResponse {
  bool isSuccessful;
  String message;

  MessageResponse({
    required this.isSuccessful,
    required this.message,
  });
}

class ReserveProvider extends ChangeNotifier {
  Future<MessageResponse> registerReserve({
    required int idUsuario,
    required int idSede,
    required int idEstado,
    required int idZona,
    required String fecha,
    required int cantidadPersonas,
    required String requerimientos,
  }) async {
    try {
      final response = await DioClient.instance.post('/api/reserve',
        data: {
          'id_usuario': idUsuario,
          'id_sede': idSede,
          'id_estado': idEstado,
          'id_zona': idZona,
          'fecha': fecha,
          'cantidad_personas': cantidadPersonas,
          'requerimientos': requerimientos,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        return MessageResponse(
          isSuccessful: true,
          message: "Reserva creada con éxito. ID: ${response.data["id_reserva"]}",
        );
      } else {
        return MessageResponse(
          isSuccessful: false,
          message: "Error al registrar la reserva",
        );
      }
    } on DioException catch (e) {
      return MessageResponse(
        isSuccessful: false,
        message: e.response?.data["error"] ?? "Error en la reserva",
      );
    } catch (e) {
      return MessageResponse(
        isSuccessful: false,
        message: "Error inesperado",
      );
    }
  }
}