class Reserva {
  final int id_reserva;
  final int id_usuario;
  final int id_sede;
  int id_estado;
  final int id_zona;
  final DateTime fecha;
  final int cantidad_personas;
  final String detalle;

  Reserva({
    required this.id_reserva,
    required this.id_usuario,
    required this.id_sede,
    required this.id_estado,
    required this.id_zona,
    required this.fecha,
    required this.cantidad_personas,
    required this.detalle,
  });
}
