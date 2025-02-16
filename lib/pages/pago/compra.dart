import 'package:flutter/material.dart';
import 'package:food_hub/domain/cart_item.dart';
import 'package:food_hub/domain/tipo_compra.dart';
import 'package:food_hub/domain/tipo_pago.dart';
import 'package:food_hub/providers/shared_provider.dart';
import 'package:food_hub/widgets/app_menu.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatefulWidget {
  final List<CartItem> items;
  final double subtotal;
  const PaymentScreen({super.key, required this.items, required this.subtotal});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  bool _isLoading = false;
  final Color defaultColor = const Color.fromARGB(255, 230, 230, 230);
  final Color selectedColor = Colors.teal;

  double deliveryCost = 20.00;
  bool _isDeliverySelect = false;
  Set selectMetodoCompra = {1};
  Set selectMetodoPago = {1};
  
  List<TipoCompra> tiposCompra = [];
  List<TipoPago> tiposPago = [];

  // List<ButtonSegment> listButtonTipoCompra = [];
  // List<ButtonSegment> listButtonTipoPago = [];

  // final List<Map<String, dynamic>> tiposCompra = [
  //   {
  //     "id_tipo_compra": 1,
  //     "tipo_compra": "Recojo en tienda"
  //   },
  //   {
  //     "id_tipo_compra": 2,
  //     "tipo_compra": "Delivery"
  //   }
  // ];

  
  
  Future<void> _loadTypes() async {
    // cargamos los datos de los platillos
    setState(() => _isLoading = true);
    await Provider.of<SharedProvider>(context, listen: false).getTypesPayment();
    await Provider.of<SharedProvider>(context, listen: false).getTypesPruchase();
  
    setState(() {
      _isLoading = false;
      // tiposPago = Provider.of<SharedProvider>(context, listen: false).tipoPagoList;
      // tiposCompra = Provider.of<SharedProvider>(context, listen: false).tipoCompraList;
    });
  }

  @override
  void initState() {
    super.initState();

    _loadTypes();
    // print(tiposPago);
    // print(tiposCompra);

    // for (var e in tiposCompra) {
    //   listButtonTipoCompra.add(
    //     ButtonSegment(
    //       value: e.idTipoCompra,
    //       label: Text(e.tipoCompra),
    //       icon: Icon(Icons.delivery_dining, color: Colors.black,),
    //     ),
    //   );
    // }

    // for (var e in tiposPago) {
    //   listButtonTipoPago.add(
    //     ButtonSegment(
    //       value: e.idTipoPago,
    //       label: Text(e.tipoPago),
    //       icon: Icon(Icons.delivery_dining, color: Colors.black,),
    //     ),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {

    final tiposPago = context.read<SharedProvider>().tipoPagoList;
    final tiposCompra = context.read<SharedProvider>().tipoCompraList;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.teal),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "¿Cómo quieres pagar?",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // alineamiento
            children: [
                // Método de pago
                // Card(
                //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                //   elevation: 2,
                //   child: ListTile(
                //     leading: const Icon(Icons.credit_card, color: Colors.teal),
                //     title: const Text("Agregar tarjeta"),
                //     subtitle: const Text("Débito o crédito"),
                //     trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                //     onTap: () {},
                //   ),
                // ),
                const Text(
                  "Método de pago",
                  textAlign: TextAlign.left ,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                ),
                const SizedBox(height: 10),
                
                _isLoading 
                ? Center(child: CircularProgressIndicator(color: selectedColor))
                : SizedBox(
                    width: double.infinity,
                    child: SegmentedButton(
                      style: SegmentedButton.styleFrom(
                        backgroundColor: Colors.white,
                        iconColor: Colors.white,
                        selectedForegroundColor: Colors.white,
                        selectedBackgroundColor: selectedColor,
                      ),
                      segments: tiposPago.map((e){
                        return ButtonSegment(
                          value: e.idTipoPago,
                          label: Text(e.tipoPago),
                          icon: Icon(Icons.delivery_dining, color: Colors.black,),
                        );
                      }).toList(),  
                      selected: selectMetodoPago,
                      onSelectionChanged: (Set<dynamic> newSelection) {
                        setState(() {
                          selectMetodoPago = newSelection;
                        });
                      },
                    ),
                  ),
                const SizedBox(height: 20),
          
                // Método de envío
                const Text(
                  "Método de envío",
                  textAlign: TextAlign.left ,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                ),
                const SizedBox(height: 10),
                
                _isLoading 
                ? Center(child: CircularProgressIndicator(color: selectedColor)) 
                : SizedBox(
                  width: double.infinity,
                  child: SegmentedButton(
                    style: SegmentedButton.styleFrom(
                      backgroundColor: Colors.white,
                      iconColor: Colors.white,
                      selectedForegroundColor: Colors.white,
                      selectedBackgroundColor: selectedColor,
                    ),
                    segments: tiposCompra.map((e){
                      return ButtonSegment(
                        value: e.idTipoCompra,
                        label: Text(e.tipoCompra),
                        icon: Icon(Icons.delivery_dining, color: Colors.black,),
                      );
                    }).toList(), 
                    selected: selectMetodoCompra,
                    onSelectionChanged: (Set<dynamic> newSelection) {
                      setState(() {
                        selectMetodoCompra = newSelection;
                        if (newSelection.first == 2){
                          _isDeliverySelect = true;
                          deliveryCost = 20.00;
                        }else{
                          _isDeliverySelect = false;
                          deliveryCost = 0.00;
                        }
                      });
                    },
                  ),
                ),
                const SizedBox(height: 10),
          
                // Detalles del pedido
                const Text("Detalles del pedido", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
          
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.items.length,
                  itemBuilder: (context, index) {
                    final item =  widget.items[index];
                    return _buildOrderItem(item.name, "S/. ${item.costo.toStringAsFixed(2)}", item.imageUrl, item.cantidad);
                  }
                ),
                const SizedBox(height: 20),
          
                // Detalles de pago
                const Text("Detalles de pago", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),

                _isDeliverySelect 
                ? Column(
                    children: [
                      _buildPaymentDetail("Subtotal", "S/. ${widget.subtotal.toStringAsFixed(2)}"),
                      _buildPaymentDetail("Costo de envío", "S/. ${deliveryCost.toStringAsFixed(2)}")
                    ],
                  )
                : SizedBox(height: 10),

                const Divider(thickness: 1),
                _buildPaymentDetail("Total", "S/. ${(widget.subtotal + deliveryCost).toStringAsFixed(2)}", isTotal: true),
                const SizedBox(height: 20),
          
                // Botón de pago
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text("Pagar", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            // ),
          ),
        ),
      ),
      bottomNavigationBar: AppMenu(),
    );
  }

  Widget _buildOrderItem(String title, String price, String imagePath, int quantity) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Image.asset(imagePath, width: 50, height: 50, fit: BoxFit.cover),
        title: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        subtitle: Text(price, style: const TextStyle(fontSize: 14, color: Colors.red)),
        trailing: Text("x$quantity", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildPaymentDetail(String label, String amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: isTotal ? 18 : 14, fontWeight: isTotal ? FontWeight.bold : FontWeight.normal),
          ),
          Text(
            amount,
            style: TextStyle(fontSize: isTotal ? 18 : 14, fontWeight: isTotal ? FontWeight.bold : FontWeight.normal),
          ),
        ],
      ),
    );
  }
}