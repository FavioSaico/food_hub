import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_hub/domain/compra_historial.dart';
import 'package:food_hub/domain/compra_registro.dart';
import 'package:food_hub/domain/dio.dart';
import 'package:food_hub/domain/estadoreserva.dart';

class MessageResponseCompraProvider<T> {
  bool isSuccessful;
  T? data;
  String message;

  MessageResponseCompraProvider(
      {required this.isSuccessful, required this.message, this.data});
}

class CompraProvider extends ChangeNotifier {

  List<HistorialCompra> listaCompras = [];
  List<Estado> states = [];

  // Método para obtener el historial de compras
  Future<MessageResponseCompraProvider<List<HistorialCompra>>> getListPurchases() async {
    try {
      final response = await DioClient.instance.get('/api/purchases');
      if (response.statusCode == 200) {
        // Mapear la respuesta y devolver la lista de compras
        List<HistorialCompra> lista = historialCompraFromJson(json.encode(response.data));

        return MessageResponseCompraProvider<List<HistorialCompra>>(
          isSuccessful: true,
          data: lista,
          message: "Se obtuvo la lista correctamente",
        );
      } else {
        return MessageResponseCompraProvider<List<HistorialCompra>>(
          isSuccessful: false,
          message: "Error al obtener la lista de compras",
        );
      }
    } on DioException catch (e) {
      return MessageResponseCompraProvider<List<HistorialCompra>>(
        isSuccessful: false,
        message: e.response?.data["error"] ?? "Error al obtener la lista de compras",
      );
    } catch (e) {
      return MessageResponseCompraProvider<List<HistorialCompra>>(
          isSuccessful: false,
          message: "Error inesperado",
        );
    }
  }

  // Método para obtener compras por usuario
  Future<MessageResponseCompraProvider<List<HistorialCompra>>> getListPurchasesByUser(int userId) async {
    try {
      final response = await DioClient.instance.get('/api/purchase/user/$userId');

      if (response.statusCode == 200) {

        List<HistorialCompra> historial = historialCompraFromJson(json.encode(response.data));

        return MessageResponseCompraProvider<List<HistorialCompra>>(
          isSuccessful: true,
          data: historial,
          message: "Se obtuvo el historial correctamente",
        );
      } else {

        return MessageResponseCompraProvider<List<HistorialCompra>>(
          isSuccessful: false,
          message: "Error al obtener el historial de compras",
        );
      }
    } on DioException catch (e) {
      return MessageResponseCompraProvider<List<HistorialCompra>>(
        isSuccessful: false,
        message: e.response?.data["error"] ?? "Error al obtener el historial de compras",
      );
    } catch (e) {
      print(e);
      return MessageResponseCompraProvider<List<HistorialCompra>>(
          isSuccessful: false,
          message: "Error inesperado",
        );
    }
  }

  // Método para obtener el detalle de una compra específica
  // Future<HistorialCompra> getPurchase(int id) async {
  //   try {
  //     final response = await DioClient.instance.get('/api/purchase/$id');
  //     if (response.statusCode == 200) {
  //       return HistorialCompra.fromJson(response.data);
  //     } else {
  //       throw Exception("Error al obtener los detalles de la compra");
  //     }
  //   } catch (e) {
  //     throw Exception("Error inesperado");
  //   }
  // }

  // Método para registrar una compra
  Future<MessageResponseCompraProvider<int>> registerCompra({
    required CompraRegistro compra, // Aquí pasas la instancia de CompraRegistro
  }) async {
    try {
      final response = await DioClient.instance.post(
        '/api/purchase',
        data: compra.toJson(), // Llamas al método toJson de CompraRegistro
      );

      if (response.statusCode == 200 && response.data != null) {
        return MessageResponseCompraProvider<int>(
          isSuccessful: true,
          data: response.data["id_compra"],
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

  // // Método para obtener los estados de compra
  // Future<List<Estado>> fetchStates() async {
  //   try {
  //     final response = await DioClient.instance.get('/api/states');
  //     if (response.statusCode == 200) {
  //       states =
  //           (response.data as List).map((e) => Estado.fromJson(e)).toList();
  //       notifyListeners(); // Notificar a los listeners de un cambio
  //       return states; // Retorna los estados después de la asignación
  //     } else {
  //       throw Exception("Error al obtener los estados");
  //     }
  //   } catch (e) {
  //     throw Exception("Error inesperado");
  //   }
  // }
}
