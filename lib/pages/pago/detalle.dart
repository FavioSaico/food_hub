import 'package:flutter/material.dart';
import 'package:food_hub/domain/compra_detalle.dart';
import 'package:food_hub/domain/estadoreserva.dart';
import 'package:food_hub/domain/food_response.dart';
import 'package:food_hub/pages/user/admin_compras.dart';
import 'package:food_hub/providers/auth_provider.dart';
import 'package:food_hub/providers/compra_provider.dart';
import 'package:food_hub/providers/shared_provider.dart';
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
  bool _isAdmin = false;
  int selectedValue = 1;
  List<Estado> opciones = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isAdmin = Provider.of<AuthProvider>(context, listen: false).currentUser!.typeUser == "ADMIN";
    });

    _obtenerCompra();
  }

  Future<void> _obtenerCompra() async {
    setState(() => _isLoading = true);
    response = await Provider.of<CompraProvider>(context, listen: false).getPurchase(widget.compraId);
    _isSuccessful = response!.isSuccessful;
    compraDetalle = response!.data;
    selectedValue = _isSuccessful ? compraDetalle!.estado.id : 1;

    await Provider.of<SharedProvider>(context, listen: false).getStates();
    opciones = Provider.of<SharedProvider>(context, listen: false).estadosList;

    setState(() => _isLoading = false);
  }
  @override
  Widget build(BuildContext context) {

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
              fontWeight: FontWeight.bold,),
        ),
        backgroundColor: Colors.white,
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
                
                _isAdmin 
                ? _buildSelectState(compraDetalle!.idCompra)
                : Row(
                  children: [
                    Text("Estado:", style: TextStyle(fontWeight: FontWeight.bold,fontSize:16)),
                    SizedBox(width: 5),
                    Text(compraDetalle!.estado.tipo, style: TextStyle(color: AppColors.mainColor,fontSize:16, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
        )
        : ErrorMessage(message: response!.message),
      bottomNavigationBar: AppMenu(selectedIndex: 3),
    );
  }

  Widget _buildItem(final ComidaResponse comida) {

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
                  Text(comida.tipoComida, style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500)),
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

  Widget _buildSelectState(int idCompra) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              Text("Cambiar estado:", style: TextStyle(fontWeight: FontWeight.bold, fontSize:16)),
              SizedBox(
                width: 20,
              ),
              SizedBox(
                child: opciones.isNotEmpty ? DropdownButton<int>(
                  icon: Icon(Icons.keyboard_arrow_down, color: AppColors.mainColor, size: 30),
                  borderRadius: BorderRadius.circular(10),
                  isExpanded: false,
                  value: selectedValue,
                  onChanged: (int? newValue) {
                    setState(() {
                      selectedValue = newValue!;
                    });
                  },
                  underline: Container(height: 1, color: Colors.black,), // Línea debajo del dropdown
                  items: opciones.map((value) {
                    return DropdownMenuItem<int>(
                      value: value.id,
                      child: Padding(
                        padding: EdgeInsets.only(right: 30),
                        child: Text(value.tipo),
                      ),
                    );
                  }).toList(),
                )
                : Center(child: CircularProgressIndicator(color: AppColors.mainColor, backgroundColor: Colors.white,))
              ),
            ],
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red,),
                onPressed: selectedValue != compraDetalle!.estado.id ? () => {
                  Navigator.pop(context)
                }
                : null,
                child: const Text('Cancelar', style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.mainColor),
                onPressed: selectedValue != compraDetalle!.estado.id ? () async {
                  final provider = Provider.of<CompraProvider>(context, listen: false);
                  MessageResponseCompraProvider<int> response = await provider.updatePurchaseState(idCompra,selectedValue);

                  if(response.isSuccessful){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Estado actualizado con éxito")),
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => AdminComprasPage()),
                    );
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(response.message)),
                    );
                  }
                } : null,                            
                child: const Text('Guardar', style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
