class TipoPago {
  final int idTipoPago;
  final String tipoPago;

  TipoPago({
    required this.idTipoPago,
    required this.tipoPago,
  });

  factory TipoPago.fromJson(Map<String, dynamic> json) => TipoPago(
    idTipoPago: json["id_tipo_pago"],
    tipoPago: json["tipo_pago"],
  );

  Map<String, dynamic> toJson() => {
    "id_tipo_pago": idTipoPago,
    "tipo_pago": tipoPago,
  };
}