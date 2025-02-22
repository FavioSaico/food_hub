class Reserva {
  final int id_reserva;
  final int id_usuario;
  final int id_sede;
   int id_estado;
  final int? id_zona;
  final DateTime fecha;
  final int? cantidad_personas;
  final String? detalle;
  final String? sede_nombre;
  final String? estado_nombre;

  Reserva({
    required this.id_reserva,
    required this.id_usuario,
    required this.id_sede,
    required this.id_estado,
    this.id_zona,
    required this.fecha,
    this.cantidad_personas,
    this.detalle,
    this.sede_nombre,
    this.estado_nombre,
  });
}
