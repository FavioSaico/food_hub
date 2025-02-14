class CartItem {
  final int idCompra;
  final int idComida;
  int cantidad;
  final double costo;

  CartItem({
    required this.idCompra,
    required this.idComida,
    required this.cantidad,
    required this.costo,
  });

  Map<String, dynamic> toJson() {
    return {
      'idCompra': idCompra,
      'idComida': idComida,
      'cantidad': cantidad,
      'costo': costo,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      idCompra: json['idCompra'],
      idComida: json['idComida'],
      cantidad: json['cantidad'],
      costo: json['costo'].toDouble(),
    );
  }
}