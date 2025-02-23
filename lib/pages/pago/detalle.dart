import 'package:flutter/material.dart';
import 'package:food_hub/domain/compra_detalle.dart';
import 'package:food_hub/domain/food_response.dart';
import 'package:food_hub/providers/compra_provider.dart';
import 'package:food_hub/utils/colors.dart';
import 'package:food_hub/utils/date.dart';
import 'package:food_hub/widgets/app_menu.dart';
import 'package:food_hub/widgets/error_message.dart';
import 'package:provider/provider.dart';

class DetalleCompraScreen extends StatefulWidget {
  final int compraId;
  const DetalleCompraScreen({super.key, required this.compraId});

  @override
  State<DetalleCompraScreen> createState() => _DetalleCompraScreenState();
}

class _DetalleCompraScreenState extends State<DetalleCompraScreen> {
  CompraDetalle? compraDetalle;
  MessageResponseCompraProvider<CompraDetalle>? response;
  bool _isLoading = false;
  bool _isSuccessful = true;

  @override
  void initState() {
    super.initState();
    _obtenerCompra();
  }

  Future<void> _obtenerCompra() async {
    setState(() => _isLoading = true);
    response = await Provider.of<CompraProvider>(context, listen: false).getPurchase(widget.compraId);
    _isSuccessful = response!.isSuccessful;
    compraDetalle = response!.data;
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.white),
          style: IconButton.styleFrom(
            backgroundColor: AppColors.mainColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          "Detalle de compra",
          style: TextStyle(color: AppColors.mainColor,fontSize: 22,
              fontWeight: FontWeight.bold,), // Color del texto
        ),
        backgroundColor: Colors.white, // Color de fondo
        // iconTheme: IconThemeData(color: AppColors.mainColor), // Color del icono de retroceso
        elevation: 0,
      ),
      body: _isLoading
      ? SizedBox(height: 100, child: Center(child: CircularProgressIndicator(color: AppColors.mainColor, backgroundColor: Colors.white,)))
      : _isSuccessful 
        ? SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Compra # ${(compraDetalle!.idCompra > 0 && compraDetalle!.idCompra <= 9) ? "00": (compraDetalle!.idCompra > 9 ? "0" : "")}${compraDetalle!.idCompra}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          Text("Fecha de compra: ${AppDate.formateoFechaSimple(compraDetalle!.fecha)}"),
                          Text("Tipo de entrega: ${compraDetalle!.tipoCompra.tipoCompra}"),
                          Text("Tipo de pago: ${compraDetalle!.tipoPago.tipoPago}"),
                          SizedBox(height: 8),
                          Text("Costo total: S/. ${compraDetalle!.costoTotal.toStringAsFixed(2)}", style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text("Platillos", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: compraDetalle!.listaComidas.length,
                  itemBuilder: (context, index) {
                      final ComidaResponse comida = compraDetalle!.listaComidas[index];
                      return _buildItem(comida);
                    },
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Text("Estado:", style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(width: 5),
                    Text(compraDetalle!.estado.tipo, style: TextStyle(color: AppColors.mainColor, fontWeight: FontWeight.bold)),
                  ],
                )
              ],
            ),
          ),
        )
        : ErrorMessage(message: response!.message),
      bottomNavigationBar: AppMenu(selectedIndex: 3,),
    );
  }

  Widget _buildItem(final ComidaResponse comida) {

    // final ComidaResponse comida;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(comida.imagen, width: 80, height: 80, fit: BoxFit.cover),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(comida.comida, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(comida.tipoComida, style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 5),
                  Text("Precio unitario: S/. ${comida.costo.toStringAsFixed(2)}"),
                  Text("Cantidad: ${comida.cantidad}"),
                  Text("Costo: S/. ${(comida.costo * comida.cantidad).toStringAsFixed(2)}", style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
