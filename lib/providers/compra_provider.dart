import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_hub/domain/compra_registro.dart';
import 'package:food_hub/domain/dio.dart';

class MessageResponseCompraProvider {
  bool isSuccessful;
  int idCompra;
  String message;

  MessageResponseCompraProvider({
    required this.isSuccessful,
    required this.message,
    this.idCompra = 0
  });
}

class CompraProvider extends ChangeNotifier {
  Future<MessageResponseCompraProvider> registerCompra({
    required CompraRegistro compra,
  }) async {
    try {
      final response = await DioClient.instance.post('/api/purchase',
        data: compra.toJson(),
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
          message: "Error al registrar la reserva",
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
}