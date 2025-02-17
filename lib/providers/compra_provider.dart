import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_hub/domain/compra_registro.dart';
import 'package:food_hub/domain/dio.dart';

class MessageResponseCompraProvider {
  bool isSuccessful;
  int idCompra;
  String message;

  MessageResponseCompraProvider(
      {required this.isSuccessful, required this.message, this.idCompra = 0});
}

class CompraProvider extends ChangeNotifier {
  // Lista de reservas y estados de compra
  List<Compra> reservations = [];
  List<Estado> states = [];

  // Método para obtener todos los tipos de pago
  Future<List<TipoPago>> getTypesPayment() async {
    try {
      final response = await DioClient.instance.get('/api/payment_types');
      if (response.statusCode == 200) {
        // Mapear la respuesta y devolver los tipos de pago
        return (response.data as List)
            .map((e) => TipoPago.fromJson(e))
            .toList();
      } else {
        throw Exception("Error al obtener los tipos de pago");
      }
    } catch (e) {
      throw Exception("Error inesperado");
    }
  }

  // Método para obtener todos los tipos de compra
  Future<List<TipoCompra>> getTypesPurchase() async {
    try {
      final response = await DioClient.instance.get('/api/purchase_types');
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((e) => TipoCompra.fromJson(e))
            .toList();
      } else {
        throw Exception("Error al obtener los tipos de compra");
      }
    } catch (e) {
      throw Exception("Error inesperado");
    }
  }

  // Método para obtener el historial de compras
  Future<List<Compra>> getListPurchases() async {
    try {
      final response = await DioClient.instance.get('/api/purchases');
      if (response.statusCode == 200) {
        // Mapear la respuesta y devolver la lista de compras
        return (response.data as List).map((e) => Compra.fromJson(e)).toList();
      } else {
        throw Exception("Error al obtener el historial de compras");
      }
    } catch (e) {
      throw Exception("Error inesperado");
    }
  }

  // Método para obtener compras por usuario
  Future<List<Compra>> getListPurchasesByUser(int userId) async {
    try {
      final response =
          await DioClient.instance.get('/api/purchases/user/$userId');
      if (response.statusCode == 200) {
        return (response.data as List).map((e) => Compra.fromJson(e)).toList();
      } else {
        throw Exception("Error al obtener las compras del usuario");
      }
    } catch (e) {
      throw Exception("Error inesperado");
    }
  }

  // Método para obtener el detalle de una compra específica
  Future<Compra> getPurchase(int id) async {
    try {
      final response = await DioClient.instance.get('/api/purchase/$id');
      if (response.statusCode == 200) {
        return Compra.fromJson(response.data);
      } else {
        throw Exception("Error al obtener los detalles de la compra");
      }
    } catch (e) {
      throw Exception("Error inesperado");
    }
  }

  // Método para registrar una compra
  Future<MessageResponseCompraProvider> registerCompra({
    required CompraRegistro compra, // Aquí pasas la instancia de CompraRegistro
  }) async {
    try {
      final response = await DioClient.instance.post(
        '/api/purchase',
        data: compra.toJson(), // Llamas al método toJson de CompraRegistro
      );

      if (response.statusCode == 200 && response.data != null) {
        return MessageResponseCompraProvider(
          isSuccessful: true,
          idCompra: response.data["id_compra"],
          message: "Pago realizado correctamente",
        );
      } else {
        return MessageResponseCompraProvider(
          isSuccessful: false,
          message: "Error al registrar la compra",
        );
      }
    } on DioException catch (e) {
      return MessageResponseCompraProvider(
        isSuccessful: false,
        message: e.response?.data["error"] ?? "Error en la compra",
      );
    } catch (e) {
      return MessageResponseCompraProvider(
        isSuccessful: false,
        message: "Error inesperado",
      );
    }
  }

  // Método para actualizar el estado de la compra
  Future<MessageResponseCompraProvider> updateReserveState(
      int reservaId, int estadoId) async {
    try {
      final response = await DioClient.instance.put(
        '/api/purchase/$reservaId/state',
        data: {'id_estado': estadoId},
      );

      if (response.statusCode == 200) {
        return MessageResponseCompraProvider(
          isSuccessful: true,
          message: "Estado de la compra actualizado correctamente",
        );
      } else {
        return MessageResponseCompraProvider(
          isSuccessful: false,
          message: "Error al actualizar el estado de la compra",
        );
      }
    } catch (e) {
      return MessageResponseCompraProvider(
        isSuccessful: false,
        message: "Error inesperado",
      );
    }
  }

  // Método para obtener los estados de compra
  Future<List<Estado>> fetchStates() async {
    try {
      final response = await DioClient.instance.get('/api/states');
      if (response.statusCode == 200) {
        states =
            (response.data as List).map((e) => Estado.fromJson(e)).toList();
        notifyListeners(); // Notificar a los listeners de un cambio
        return states; // Retorna los estados después de la asignación
      } else {
        throw Exception("Error al obtener los estados");
      }
    } catch (e) {
      throw Exception("Error inesperado");
    }
  }
}

// Modelos de datos para Compra, Estado, TipoPago, etc.
class Compra {
  final int id;
  final String fecha;
  final Estado estado;
  // Otros campos según tu estructura

  Compra({
    required this.id,
    required this.fecha,
    required this.estado,
  });

  factory Compra.fromJson(Map<String, dynamic> json) {
    return Compra(
      id: json['id_compra'],
      fecha: json['fecha'],
      estado: Estado.fromJson(json['estado']),
      // Mapear otros campos
    );
  }
}

class Estado {
  final int id;
  final String tipo;

  Estado({required this.id, required this.tipo});

  factory Estado.fromJson(Map<String, dynamic> json) {
    return Estado(
      id: json['id_estado'],
      tipo: json['tipo_estado'],
    );
  }
}

class TipoPago {
  final int id;
  final String tipo;

  TipoPago({required this.id, required this.tipo});

  factory TipoPago.fromJson(Map<String, dynamic> json) {
    return TipoPago(
      id: json['id_tipo_pago'],
      tipo: json['tipo_pago'],
    );
  }
}

class TipoCompra {
  final int id;
  final String tipo;

  TipoCompra({required this.id, required this.tipo});

  factory TipoCompra.fromJson(Map<String, dynamic> json) {
    return TipoCompra(
      id: json['id_tipo_compra'],
      tipo: json['tipo_compra'],
    );
  }
}

// Renombré la clase MessageResponseCompraProvider para evitar el conflicto de nombres
class MessageResponseCompra {
  final bool isSuccessful;
  final int? idCompra;
  final String message;

  MessageResponseCompra({
    required this.isSuccessful,
    this.idCompra,
    required this.message,
  });
}

class DioClient {
  // Asegúrate de que este DioClient esté configurado correctamente
  static Dio instance = Dio();
}
