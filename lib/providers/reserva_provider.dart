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

//modelo de reserva
class Reserva {
  final int id_reserva;
  final int id_usuario;
  final int id_sede;
  int id_estado;
  final int id_zona;
  final DateTime fecha;
  final int cantidad_personas;
  final String detalle;

  Reserva({
    required this.id_reserva,
    required this.id_usuario,
    required this.id_sede,
    required this.id_estado,
    required this.id_zona,
    required this.fecha,
    required this.cantidad_personas,
    required this.detalle,
  });
}

//Modelo de estado de reserva

class EstadoReserva {
  final int id_reserva;
  final String name;

  EstadoReserva({
    required this.id_reserva,
    required this.name,
  });
}

class ReserveProvider extends ChangeNotifier {
  List<Reserva> reservations = [];
  List<EstadoReserva> states = []; // Lista de estados de reserva

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
        '/api/reserve',
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
      final response = await DioClient.instance.get('/api/reserves');

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
            detalle: reserva['detalle'],
          );
        }).toList();
        notifyListeners();
      }
    } catch (e) {
      print("Error al obtener reservas: $e");
    }
  }

  /// Método para obtener los estados de reserva desde la API
  Future<void> fetchStates() async {
    try {
      final response = await DioClient.instance
          .get('/api/estados'); // URL para obtener los estados
      // Mapea la respuesta a una lista de EstadoReserva
      states = (response.data as List)
          .map((e) =>
              EstadoReserva(id_reserva: e['id_estado'], name: e['tipo_estado']))
          .toList();
      notifyListeners();
    } catch (e) {
      print('Error al obtener los estados: $e');
    }
  }

  /// Método para actualizar el estado de una reserva
  Future<void> updateReserveState(int reservaId, int newState) async {
    try {
      final response = await DioClient.instance.put(
        '/api/reserve/update',
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
