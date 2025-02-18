import 'package:food_hub/domain/estadoreserva.dart';

class CompraHistorial {
  final int id_compra;
  final DateTime fecha;
  int id_estado;
  double costoTotal;
  // Otros campos según tu estructura

  CompraHistorial({
    required this.id_compra,
    required this.fecha,
    required this.id_estado,
    required this.costoTotal,
  });
  factory CompraHistorial.fromJson(Map<String, dynamic> json) {
    return CompraHistorial(
      id_compra: json['id_compra'],
      fecha: DateTime.parse(json['fecha']), // Convertir fecha a DateTime
      id_estado: json['id_estado'],
      costoTotal: (json['costoTotal'] as num)
          .toDouble(), // Convertir a double si es necesario
    );
  }
}
