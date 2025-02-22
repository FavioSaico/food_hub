import 'package:flutter/material.dart';

class DetalleCompraScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
        title: Text(
          "Detalle de compra",
          style: TextStyle(color: Color(0xFF5CABA1)), // Color del texto
        ),
        backgroundColor: Colors.white, // Color de fondo
        iconTheme: IconThemeData(color: Color(0xFF5CABA1)), // Color del icono de retroceso
        elevation: 0, // Sin sombra
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Compra # 0003", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text("Fecha de compra: 23/01/2025 19:50"),
                    Text("Tipo de entrega: Recogo en tienda"),
                    Text("Tipo de pago: Pago contra entrega"),
                    Text("Estado: En proceso"),
                    SizedBox(height: 8),
                    Text("Costo total: S/. 168.00", style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Text("Platillos", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            _buildItem("Arroz con mariscos", "Fuente", 46.00, 2, "assets/imagenes/ARROZ_CON_MARISCOS.png"),
            _buildItem("Trío clásico", "Piqueos", 56.00, 1, "assets/imagenes/trioclasico.png"),
            SizedBox(height: 16),
            Row(
              children: [
                Text("Estado:", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(width: 5),
                Text("En proceso", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              ],
            )
          ],
        ),
      ),

    );
  }

  Widget _buildItem(String nombre, String tipo, double precio, int cantidad, String imagen) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(imagen, width: 80, height: 80, fit: BoxFit.cover),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(nombre, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(tipo, style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 5),
                  Text("Precio unitario: S/. ${precio.toStringAsFixed(2)}"),
                  Text("Cantidad: $cantidad"),
                  Text("Costo: S/. ${(precio * cantidad).toStringAsFixed(2)}", style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
