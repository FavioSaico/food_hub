class ComidaResponse {
    int idComida;
    String comida;
    String tipoComida;
    double precio;
    int cantidad;
    double costo;
    String imagen;

    ComidaResponse({
        required this.idComida,
        required this.comida,
        required this.tipoComida,
        required this.precio,
        required this.cantidad,
        required this.costo,
        required this.imagen,
    });

    factory ComidaResponse.fromJson(Map<String, dynamic> json) => ComidaResponse(
        idComida: json["id_comida"],
        comida: json["comida"],
        tipoComida: json["tipo_comida"],
        precio: json["precio"]?.toDouble(),
        cantidad: json["cantidad"],
        costo: json["costo"]?.toDouble(),
        imagen: json["imagen"],
    );

    Map<String, dynamic> toJson() => {
        "id_comida": idComida,
        "comida": comida,
        "tipo_comida": tipoComida,
        "precio": precio,
        "cantidad": cantidad,
        "costo": costo,
        "imagen": imagen,
    };
}