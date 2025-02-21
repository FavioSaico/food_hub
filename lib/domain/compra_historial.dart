import 'dart:convert';
import 'package:food_hub/domain/estadoreserva.dart';
import 'package:food_hub/domain/sedes.dart';
import 'package:food_hub/domain/tipo_compra.dart';
import 'package:food_hub/domain/tipo_pago.dart';

List<HistorialCompra> historialCompraFromJson(String str) => List<HistorialCompra>.from(json.decode(str).map((x) => HistorialCompra.fromJson(x)));

String historialCompraToJson(List<HistorialCompra> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HistorialCompra {
    int idCompra;
    int idUsuario;
    TipoCompra tipoCompra;
    TipoPago tipoPago;
    Estado estado;
    Sede sede;
    double costoTotal;
    DateTime fecha;

    HistorialCompra({
        required this.idCompra,
        required this.idUsuario,
        required this.tipoCompra,
        required this.tipoPago,
        required this.estado,
        required this.sede,
        required this.costoTotal,
        required this.fecha,
    });

    factory HistorialCompra.fromJson(Map<String, dynamic> json) => HistorialCompra(
        idCompra: json["id_compra"],
        idUsuario: json["id_usuario"],
        tipoCompra: TipoCompra.fromJson(json["tipo_compra"]),
        tipoPago: TipoPago.fromJson(json["tipo_pago"]),
        estado: Estado.fromJson(json["estado"]),
        sede: Sede.fromJson(json["sede"]),
        costoTotal: json["costo_total"].toDouble(),
        fecha: DateTime.parse(json["fecha"]),
    );

    Map<String, dynamic> toJson() => {
        "id_compra": idCompra,
        "id_usuario": idUsuario,
        "tipo_compra": tipoCompra.toJson(),
        "tipo_pago": tipoPago.toJson(),
        "estado": estado.toJson(),
        "sede": sede.toJson(),
        "costo_total": costoTotal,
        "fecha": fecha.toIso8601String(),
    };
}