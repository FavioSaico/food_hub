import 'package:flutter/material.dart';

class PaymentScreen2 extends StatefulWidget {
  const PaymentScreen2({super.key});

  @override
  _PaymentScreenState2 createState() => _PaymentScreenState2();
}

class _PaymentScreenState2 extends State<PaymentScreen2> {
  String selectedMethod = "store"; // Método de envío seleccionado
  final TextEditingController amountController = TextEditingController();

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tarjeta de pago en efectivo
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.account_balance_wallet, color: Colors.teal, size: 40),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("Efectivo", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            Text("Pagaré con S/____", style: TextStyle(fontSize: 14, color: Colors.grey)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: "Ingrese el monto",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Métodos de envío
            const Text("Método de envío", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.store, color: Colors.black),
                    label: const Text("Recoger en tienda"),
                    onPressed: () => setState(() => selectedMethod = "store"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedMethod == "store" ? Colors.teal[100] : Colors.grey[300],
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.delivery_dining, color: Colors.black),
                    label: const Text("Delivery"),
                    onPressed: () => setState(() => selectedMethod = "delivery"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedMethod == "delivery" ? Colors.teal[100] : Colors.grey[300],
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Detalles del pedido
            const Text("Detalles del pedido", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildOrderItem("Arroz con mariscos", "S/. 92.00", "assets/imagenes/arrozconmariscos.png", "Fuente", 2),
            _buildOrderItem("Trío clásico", "S/. 56.00", "assets/imagenes/trioclasico.png", "(ceviche, arroz con mariscos y chicharrón)", 1),
            const SizedBox(height: 20),

            // Detalles de pago
            const Text("Detalles de pago", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildPaymentDetail("Subtotal", "S/. 148.00"),
            _buildPaymentDetail("Costo de envío", selectedMethod == "delivery" ? "S/. 20.00" : "S/. 0.00"),
            const Divider(thickness: 1),
            _buildPaymentDetail("Total", selectedMethod == "delivery" ? "S/. 168.00" : "S/. 148.00", isTotal: true),
            const SizedBox(height: 20),

            // Botón de confirmación
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Center(
                child: Text("Confirmar", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItem(String title, String price, String imagePath, String subtitle, int quantity) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Image.asset(imagePath, width: 50, height: 50, fit: BoxFit.cover),
        title: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            Text(price, style: const TextStyle(fontSize: 14, color: Colors.red)),
          ],
        ),
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
