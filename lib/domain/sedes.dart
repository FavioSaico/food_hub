class Sede {
  final int idSede;
  final String sede;

  Sede({
    required this.idSede,
    required this.sede,
  });

  factory Sede.fromJson(Map<String, dynamic> json) => Sede(
    idSede: json["id_sede"],
    sede: json["sede"],
  );

  Map<String, dynamic> toJson() => {
    "id_sede": idSede,
    "sede": sede,
  };
}
