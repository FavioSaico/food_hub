class Estado {
  final int id;
  final String tipo;

  Estado({required this.id, required this.tipo});

  factory Estado.fromJson(Map<String, dynamic> json) => Estado(
    id: json["id_estado"],
    tipo: json["tipo_estado"],
  );

  Map<String, dynamic> toJson() => {
    "id_estado": id,
    "tipo_estado": tipo,
  };
}
