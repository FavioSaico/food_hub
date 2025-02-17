import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_hub/domain/reserva.dart';
import 'package:food_hub/domain/estadoreserva.dart';
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
  List<Reserva> reservations = [];
  List<EstadoReserva> states = [];

  /// Método para registrar una reserva
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
      final response = await DioClient.instance.post(
        '/api/reserve/',
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
          message:
              "Reserva creada con éxito. ID: ${response.data["id_reserva"]}",
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

  /// Método para obtener la lista de reservas
  Future<void> fetchReservations() async {
    try {
      final response = await DioClient.instance.get('/api/reserve/');

      if (response.statusCode == 200 && response.data != null) {
        reservations = (response.data as List).map((reserva) {
          return Reserva(
            id_reserva: reserva['id_reserva'],
            id_usuario: reserva['id_usuario'],
            id_sede: reserva['id_sede'],
            id_estado: reserva['id_estado'],
            id_zona: reserva['id_zona'],
            fecha: DateTime.parse(reserva['fecha']),
            cantidad_personas: reserva['cantidad_personas'],
            detalle: reserva['requerimientos'],
          );
        }).toList();
        notifyListeners();
      }
    } catch (e) {
      print("Error al obtener reservas: $e");
    }
  }

  /// Método para obtener los estados de reserva
  Future<void> fetchStates() async {
    try {
      final response = await DioClient.instance.get('/api/estado/');

      if (response.statusCode == 200 && response.data != null) {
        states = (response.data as List)
            .map((e) => EstadoReserva(
                  id_estado: e['id_estado'],
                  tipo_estado: e['tipo_estado'],
                ))
            .toList();
        notifyListeners();
      }
    } catch (e) {
      print('Error al obtener los estados: $e');
    }
  }

  /// Método para actualizar el estado de una reserva
  Future<void> updateReserveState(int reservaId, int newState) async {
    try {
      final response = await DioClient.instance.put(
        '/api/reserve/',
        data: {
          "id_reserva": reservaId,
          "id_estado": newState,
        },
      );

      if (response.statusCode == 200) {
        final index = reservations
            .indexWhere((reserva) => reserva.id_reserva == reservaId);
        if (index != -1) {
          reservations[index].id_estado = newState;
          notifyListeners();
        }
      }
    } catch (e) {
      print("Error al actualizar reserva: $e");
    }
  }
}
