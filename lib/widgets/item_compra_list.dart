
import 'package:flutter/material.dart';
import 'package:food_hub/domain/compra_historial.dart';
import 'package:intl/intl.dart';

class ItemCompraList extends StatelessWidget {

  final HistorialCompra compra;
  const ItemCompraList({super.key, required this.compra});

  String formateoFecha( DateTime date) {
    String formattedDateTime = DateFormat('EEEE d MMMM y - HH:mm', 'es_ES').format(date);
    return '${formattedDateTime[0].toUpperCase()}${formattedDateTime.substring(1)}';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3,
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        tileColor: Colors.white,
        title: Text(
          'Compra # ${(compra.idCompra > 0 && compra.idCompra <= 9) ? "00": (compra.idCompra > 9 ? "0" : "")}${compra.idCompra}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(compra.estado.tipo,style: TextStyle(color: Colors.teal),),
            Text(formateoFecha(compra.fecha))
          ],
        ),
        trailing: Text(
          "S/. ${compra.costoTotal.toStringAsFixed(2)}",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
