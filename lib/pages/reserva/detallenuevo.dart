import 'package:flutter/material.dart';

class DetalleReservaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detalle de reserva",
          style: TextStyle(color: Color(0xFF5CABA1)), // Color del texto
        ),
        backgroundColor: Colors.white, // Color de fondo
        iconTheme: IconThemeData(color: Color(0xFF5CABA1)), // Color del icono de retroceso
        elevation: 0, // Sin sombra
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildReservaInfo(),
            SizedBox(height: 16),
            _buildEstado(),
          ],
        ),
      ),
    );
  }

  Widget _buildReservaInfo() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Reserva #0003", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 4),
            _buildDetailText("Día:", "30 de Enero"),
            _buildDetailText("Hora:", "14:00 hrs"),
            _buildDetailText("Cantidad de personas:", "2 persona(s)"),
            _buildDetailText("Zona preferida:", "Zona Terraza"),
            _buildDetailText("Requerimientos especiales:", "Solicito una silla para bebé"),
          ],
        ),
      ),
    );
  }

  Widget _buildEstado() {
    return RichText(
      text: TextSpan(
        text: "Estado: ",
        style: TextStyle(fontSize: 16, color: Colors.black),
        children: [
          TextSpan(
            text: "En proceso",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailText(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: RichText(
        text: TextSpan(
          text: "$title ",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
          children: [
            TextSpan(
              text: value,
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
