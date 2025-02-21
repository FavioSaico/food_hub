import 'package:flutter/material.dart';
import 'package:food_hub/domain/compra_historial.dart';
import 'package:food_hub/utils/colors.dart';
import 'package:food_hub/widgets/app_menu.dart';
import 'package:food_hub/utils/dimensions.dart';
import 'package:intl/intl.dart';

class AdminComprasPage extends StatefulWidget {
  const AdminComprasPage({super.key});
  @override
  _AdminComprasPageState createState() => _AdminComprasPageState();
}

class BackButtonCustom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 4.0), // Ajuste para pegarlo más al borde
      child: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class _AdminComprasPageState extends State<AdminComprasPage> {
  @override
  void initState() {
    super.initState();
  }

  List<HistorialCompra> listaCompras = historialCompraFromJson('[{"id_compra":5,"id_usuario":6,"tipo_compra":{"id_tipo_compra":2,"tipo_compra":"Delivery"},"tipo_pago":{"id_tipo_pago":2,"tipo_pago":"Tarjeta"},"estado":{"id_estado":3,"tipo_estado":"Finalizado"},"sede":{"id_sede":1,"sede":"C. Armando Blondet 265, San Isidro 15047"},"costo_total":110,"fecha":"2025-02-08T00:06:41.000Z"},{"id_compra":3,"id_usuario":6,"tipo_compra":{"id_tipo_compra":1,"tipo_compra":"Recojo en tienda"},"tipo_pago":{"id_tipo_pago":1,"tipo_pago":"Efectivo"},"estado":{"id_estado":3,"tipo_estado":"Finalizado"},"sede":{"id_sede":2,"sede":"Av. Aviación 2633, San Borja 15037"},"costo_total":130,"fecha":"2025-02-07T23:46:59.000Z"}]');

  String formateoFecha( DateTime date) {
    String formattedDateTime = DateFormat('EEEE d MMMM y - HH:mm', 'es_ES').format(date);
    return '${formattedDateTime[0].toUpperCase()}${formattedDateTime.substring(1)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // 🔹 Header con botón de retroceso y título centrado
          Container(
            margin: EdgeInsets.only(
                top: Dimensions.height60, bottom: Dimensions.height15),
            padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: BackButtonCustom(),
                ),
                SizedBox(height: 10),
                Text(
                  "Historial de compras",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.mainColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          // Lista de compras con el costo total en lugar del icono
          Expanded(
            child: ListView.builder(
              itemCount: listaCompras.length,
              itemBuilder: (context, index) {
                final HistorialCompra compra = listaCompras[index];
                return Card(
                  color: Colors.white,
                  elevation: 3,
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(
                      'Compra # ${(compra.idCompra > 0 && compra.idCompra < 9) ? "00": (compra.idCompra > 9 ? "0" : "")}${compra.idCompra}',
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
                        fontSize: 20, // 🔹 Tamaño más grande
                        fontWeight: FontWeight.bold, // 🔹 Negrita
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppMenu(),
        ],
      ),
    );
  }
}
