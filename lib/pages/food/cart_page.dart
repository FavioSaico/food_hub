import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food_hub/providers/food_provider.dart';
import 'package:food_hub/providers/cart_provider.dart';
import 'package:food_hub/widgets/app_menu.dart';
import 'package:food_hub/widgets/payment_details.dart';
import 'package:food_hub/widgets/cart_item_card.dart';
import 'package:food_hub/widgets/empty_cart.dart';
import 'package:food_hub/domain/food.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final foodProvider = Provider.of<FoodProvider>(context);
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
                    return FutureBuilder<Food?>(
                      future: foodProvider.getFoodById(item.idComida),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (snapshot.hasError || !snapshot.hasData) {
                          return Text('Error cargando el producto');
                        }

                        final food = snapshot.data!;
                        return CartItemCard(
                          item: item,
                          food: food,
                        );
                      },
                    );
                  },
                ),
              ),
              PaymentDetails(
                subtotal: cartProvider.subtotal,
                shippingCost: 0.00,
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: AppMenu(),
    );
  }
}
