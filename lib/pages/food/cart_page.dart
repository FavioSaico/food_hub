import 'package:flutter/material.dart';
import 'package:food_hub/pages/pago/compra.dart';
import 'package:food_hub/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:food_hub/providers/cart_provider.dart';
import 'package:food_hub/widgets/app_menu.dart';
import 'package:food_hub/widgets/payment_details.dart';
import 'package:food_hub/widgets/cart_item_card.dart';
import 'package:food_hub/widgets/empty_cart.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final foodProvider = Provider.of<FoodProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          if (cartProvider.items.isEmpty) {
            return const EmptyCart();
          }

          return Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 60,
                  bottom: 20,
                ),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Carrito de compras',
                  style: TextStyle(
                    color: Color(0xFF5BA698),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: cartProvider.items.length,
                  itemBuilder: (context, index) {
                    final item = cartProvider.items[index];
                    return CartItemCard(
                      item: item,
                    );
                  },
                ),
              ),
              PaymentDetails(
                subtotal: cartProvider.subtotal,
                // shippingCost: 0.00,
              ),
              // BOTON DE SIGUIENTE
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Implementar acción de siguiente
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        allowSnapshotting: false,
                        builder: (context) => PaymentScreen(items: cartProvider.items, subtotal: cartProvider.subtotal),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mainColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Siguiente',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: AppMenu(),
    );
  }
}
