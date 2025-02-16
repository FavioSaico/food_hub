import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_hub/domain/dio.dart';
import 'package:food_hub/domain/tipo_compra.dart';
import 'package:food_hub/domain/tipo_pago.dart';

class SharedProvider extends ChangeNotifier {

  List<TipoPago> tipoPagoList = [];
  List<TipoCompra> tipoCompraList = [];

  Future<void> getTypesPayment() async {

    try {

      final response = await DioClient.instance.get('/api/purchase/typesPayment');
      // Mapper
      if (response.statusCode == 200) {
        List<TipoPago> lista = [];
        final data = (response.data as List);
        for (var i = 0; i < data.length; i++) {
          TipoPago currentTipoPago = TipoPago(
            idTipoPago: data[i]["id_tipo_pago"], 
            tipoPago: data[i]["tipo_pago"],
          );
          lista.add(currentTipoPago);
        }
        tipoPagoList = lista;
        notifyListeners(); 
      }
    }  on DioException catch (e) {
      print(e);
      // return MessageResponse(
      //   isSuccessful: false,
      //   message: (e.response != null ? e.response?.data["error"] : "Error en la autenticación")
      // );
    } catch (e) {
      print(e);
      // return MessageResponse(isSuccessful: false, message: "Error inesperado");
    }
  }

  Future<void> getTypesPruchase() async {

    try {

      final response = await DioClient.instance.get('/api/purchase/typesPruchase');
      // Mapper
      if (response.statusCode == 200) {
        List<TipoCompra> lista = [];
        final data = (response.data as List);
        for (var i = 0; i < data.length; i++) {
          TipoCompra currentTipoCompra = TipoCompra(
            idTipoCompra: data[i]["id_tipo_compra"], 
            tipoCompra: data[i]["tipo_compra"],
          );
          lista.add(currentTipoCompra);
        }
        tipoCompraList = lista;
        notifyListeners();
      }
    }  on DioException catch (e) {
      print(e);
      // return MessageResponse(
      //   isSuccessful: false,
      //   message: (e.response != null ? e.response?.data["error"] : "Error en la autenticación")
      // );
    } catch (e) {
      print(e);
      // return MessageResponse(isSuccessful: false, message: "Error inesperado");
    }
  }
}