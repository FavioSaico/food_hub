class CartItem {
  final int idComida;
  int cantidad;
  final double costo;
  final String imageUrl;
  final String name;

  CartItem({
    required this.idComida,
    required this.cantidad,
    required this.costo,
    required this.imageUrl,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      'idComida': idComida,
      'cantidad': cantidad,
      'costo': costo,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      idComida: json['idComida'],
      cantidad: json['cantidad'],
      costo: json['costo'].toDouble(),
      imageUrl: json['image'],
      name: json['name'],
    );
  }
}