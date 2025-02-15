import 'package:flutter/material.dart';
import 'package:food_hub/domain/cart_item.dart';
import 'package:food_hub/utils/dimensions.dart';
import 'package:food_hub/widgets/app_menu.dart';

class PaymentScreen extends StatefulWidget {
  final List<CartItem> items;
  final double subtotal;
  const PaymentScreen({super.key, required this.items, required this.subtotal});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  int selectedEnvio = -1;
  int selectedMetodoPago = -1;
  final Color defaultColor = const Color.fromARGB(255, 230, 230, 230);
  final Color selectedColor = Colors.teal;

  double delivery = 20.00;
  // final double total = widget.subtotal + delivery;

  final List<Map<String, dynamic>> tiposCompra = [
    {
      "id_tipo_compra": 1,
      "tipo_compra": "Recojo en tienda"
    },
    {
      "id_tipo_compra": 2,
      "tipo_compra": "Delivery"
    }
  ];

  @override
  Widget build(BuildContext context) {
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
          margin: EdgeInsets.all(16.0),
          child: Column(
            // textDirection: TextDirection(),
            // padding: const EdgeInsets.all(16.0),
            children: [
                // Método de pago
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 2,
                  child: ListTile(
                    leading: const Icon(Icons.credit_card, color: Colors.teal),
                    title: const Text("Agregar tarjeta"),
                    subtitle: const Text("Débito o crédito"),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {},
                  ),
                ),
                const SizedBox(height: 20),
          
                // Método de envío
                const Text("Método de envío", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: tiposCompra.length,
                  itemBuilder: (context, index) {
                    final tiposComp = tiposCompra[index];
                    return ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedMetodoPago = selectedMetodoPago == index ? -1 : index;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedMetodoPago == index ?  selectedColor : defaultColor,
                        foregroundColor: selectedMetodoPago == index ? defaultColor : Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text('${tiposComp["tipo_compra"]}'),
                    );
                  }
                ),
          
                // Detalles del pedido
                const Text("Detalles del pedido", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
          
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.items.length,
                  itemBuilder: (context, index) {
                    final item =  widget.items[index];
                    return _buildOrderItem(item.name, "S/. ${item.costo}", item.imageUrl, item.cantidad);
                  }
                ),
                const SizedBox(height: 20),
          
                // Detalles de pago
                const Text("Detalles de pago", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                _buildPaymentDetail("Subtotal", "S/. ${widget.subtotal}"),
                _buildPaymentDetail("Costo de envío", "S/. $delivery"),
                const Divider(thickness: 1),
                _buildPaymentDetail("Total", "S/. ${widget.subtotal + delivery}", isTotal: true),
                const SizedBox(height: 20),
          
                // Botón de pago
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
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