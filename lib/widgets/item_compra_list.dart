
import 'package:flutter/material.dart';
import 'package:food_hub/domain/compra_historial.dart';
import 'package:food_hub/pages/pago/detalle.dart';
import 'package:food_hub/utils/date.dart';

class ItemCompraList extends StatelessWidget {

  final HistorialCompra compra;
  const ItemCompraList({super.key, required this.compra});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            allowSnapshotting: false,
            builder: (context) => DetalleCompraScreen(compraId: compra.idCompra),
          ),
        )
      },
      child: Card(
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
              Text(AppDate.formateoFechaDetalle(compra.fecha))
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
      ),
    );
  }
}
