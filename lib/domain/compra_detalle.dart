import 'dart:convert';

import 'package:food_hub/domain/estadoreserva.dart';
import 'package:food_hub/domain/food_response.dart';
import 'package:food_hub/domain/sedes.dart';
import 'package:food_hub/domain/tipo_compra.dart';
import 'package:food_hub/domain/tipo_pago.dart';

CompraDetalle compraDetalleFromJson(String str) => CompraDetalle.fromJson(json.decode(str));

String compraDetalleToJson(CompraDetalle data) => json.encode(data.toJson());

class CompraDetalle {
    int idCompra;
    Usuario usuario;
    TipoCompra tipoCompra;
    TipoPago tipoPago;
    Estado estado;
    Sede idSede;
    DateTime fecha;
    double costoSubtotal;
    double costoTotal;
    double costoDelivery;
    List<ComidaResponse> listaComidas;

    CompraDetalle({
        required this.idCompra,
        required this.usuario,
        required this.tipoCompra,
        required this.tipoPago,
        required this.estado,
        required this.idSede,
        required this.fecha,
        required this.costoSubtotal,
        required this.costoTotal,
        required this.costoDelivery,
        required this.listaComidas,
    });

    factory CompraDetalle.fromJson(Map<String, dynamic> json) => CompraDetalle(
        idCompra: json["id_compra"],
        usuario: Usuario.fromJson(json["usuario"]),
        tipoCompra: TipoCompra.fromJson(json["tipo_compra"]),
        tipoPago: TipoPago.fromJson(json["tipo_pago"]),
        estado: Estado.fromJson(json["estado"]),
        idSede: Sede.fromJson(json["id_sede"]),
        fecha: DateTime.parse(json["fecha"]),
        costoSubtotal: json["costo_subtotal"]?.toDouble(),
        costoTotal: json["costo_total"]?.toDouble(),
        costoDelivery: json["costo_delivery"]?.toDouble(),
        listaComidas: List<ComidaResponse>.from(json["lista_comidas"].map((x) => ComidaResponse.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id_compra": idCompra,
        "usuario": usuario.toJson(),
        "tipo_compra": tipoCompra.toJson(),
        "tipo_pago": tipoPago.toJson(),
        "estado": estado.toJson(),
        "id_sede": idSede.toJson(),
        "fecha": fecha.toIso8601String(),
        "costo_subtotal": costoSubtotal,
        "costo_total": costoTotal,
        "costo_delivery": costoDelivery,
        "lista_comidas": List<dynamic>.from(listaComidas.map((x) => x.toJson())),
    };
}

class Usuario {
    int idUsuario;
    String tipoUsuario;
    String nombre;
    String correo;
    String direccion;

    Usuario({
        required this.idUsuario,
        required this.tipoUsuario,
        required this.nombre,
        required this.correo,
        required this.direccion,
    });

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        idUsuario: json["id_usuario"],
        tipoUsuario: json["tipo_usuario"],
        nombre: json["nombre"],
        correo: json["correo"],
        direccion: json["direccion"],
    );

    Map<String, dynamic> toJson() => {
        "id_usuario": idUsuario,
        "tipo_usuario": tipoUsuario,
        "nombre": nombre,
        "correo": correo,
        "direccion": direccion,
    };
}
