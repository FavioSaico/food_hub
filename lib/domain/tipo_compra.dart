class TipoCompra {
  final int idTipoCompra;
  final String tipoCompra;

  TipoCompra({
    required this.idTipoCompra,
    required this.tipoCompra,
  });

  factory TipoCompra.fromJson(Map<String, dynamic> json) => TipoCompra(
    idTipoCompra: json["id_tipo_compra"],
    tipoCompra: json["tipo_compra"],
  );

  Map<String, dynamic> toJson() => {
    "id_tipo_compra": idTipoCompra,
    "tipo_compra": tipoCompra,
  };
}