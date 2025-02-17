import 'dart:convert';

CompraRegistro compraRegistroFromJson(String str) => CompraRegistro.fromJson(json.decode(str));

String compraRegistroToJson(CompraRegistro data) => json.encode(data.toJson());

class CompraRegistro {
    int idUsuario;
    int idTipoCompra;
    int idTipoPago;
    int idEstado;
    int idSede;
    double costoSubtotal;
    double costoTotal;
    double costoDelivery;
    List<ListaComida> listaComidas;

    CompraRegistro({
        required this.idUsuario,
        required this.idTipoCompra,
        required this.idTipoPago,
        required this.idEstado,
        required this.idSede,
        required this.costoSubtotal,
        required this.costoTotal,
        required this.costoDelivery,
        required this.listaComidas,
    });

    factory CompraRegistro.fromJson(Map<String, dynamic> json) => CompraRegistro(
        idUsuario: json["id_usuario"],
        idTipoCompra: json["id_tipo_compra"],
        idTipoPago: json["id_tipo_pago"],
        idEstado: json["id_estado"],
        idSede: json["id_sede"],
        costoSubtotal: json["costo_subtotal"]?.toDouble(),
        costoTotal: json["costo_total"],
        costoDelivery: json["costo_delivery"]?.toDouble(),
        listaComidas: List<ListaComida>.from(json["lista_comidas"].map((x) => ListaComida.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id_usuario": idUsuario,
        "id_tipo_compra": idTipoCompra,
        "id_tipo_pago": idTipoPago,
        "id_estado": idEstado,
        "id_sede": idSede,
        "costo_subtotal": costoSubtotal,
        "costo_total": costoTotal,
        "costo_delivery": costoDelivery,
        "lista_comidas": List<dynamic>.from(listaComidas.map((x) => x.toJson())),
    };
}

class ListaComida {
    int idComida;
    int cantidad;
    double costo;

    ListaComida({
        required this.idComida,
        required this.cantidad,
        required this.costo,
    });

    factory ListaComida.fromJson(Map<String, dynamic> json) => ListaComida(
        idComida: json["id_comida"],
        cantidad: json["cantidad"],
        costo: json["costo"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id_comida": idComida,
        "cantidad": cantidad,
        "costo": costo,
    };
}
