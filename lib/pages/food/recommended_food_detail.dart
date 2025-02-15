import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food_hub/providers/cart_provider.dart';
import 'package:food_hub/domain/food.dart';
import 'package:food_hub/domain/cart_item.dart';
import 'package:food_hub/utils/colors.dart';
import 'package:food_hub/utils/dimensions.dart';
import 'package:food_hub/widgets/app_menu.dart';
import 'package:food_hub/widgets/big_text.dart';
import 'package:food_hub/widgets/exandable_text_widget.dart';

class RecommendedFoodDetail extends StatefulWidget {
  final Food product;
  const RecommendedFoodDetail({super.key, required this.product});

  @override
  State<RecommendedFoodDetail> createState() => _RecommendedFoodDetailState();
}

class _RecommendedFoodDetailState extends State<RecommendedFoodDetail> {
  int clickCounter = 1;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Colors.white,
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.mainColor,
                  ),
                  icon: Icon(Icons.chevron_left)
                )
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20),
                    topRight: Radius.circular(Dimensions.radius20),
                  )
                ),
                child: Center(child: BigText(size: Dimensions.font26, text: widget.product.name)),
              )
            ),
            pinned: true,
            backgroundColor: AppColors.mainColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                widget.product.imageUrl,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                  child: ExpandableTextWidget(
                    text: widget.product.description
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, top: Dimensions.height20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "S/. ${widget.product.price.toString()}",
                        style: TextStyle(color: Colors.black, fontSize: Dimensions.font26, fontWeight: FontWeight.w600)
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, top: Dimensions.height30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (clickCounter > 0) {
                              clickCounter--;
                            }
                          });
                        },
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.mainColor
                        ),
                        icon: Icon(Icons.remove, color: Colors.white, size: 20),
                      ),
                      BigText(text: '$clickCounter', color: AppColors.mainBlackColor, size: Dimensions.font26),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            clickCounter++;
                          });
                        },
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.mainColor
                        ),
                        icon: Icon(Icons.add, color: Colors.white, size: 20),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (clickCounter > 0) {
                            cartProvider.addItem(
                              CartItem(
                                idCompra: clickCounter,
                                idComida: widget.product.id,
                                cantidad: clickCounter,
                                costo: widget.product.price,
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Producto agregado al carrito'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.mainColor,
                        ),
                        child: Row(
                          children: [
                            BigText(text: "Agregar", color: Colors.white, size: Dimensions.font16),
                            SizedBox(width: 10),
                            Icon(Icons.shopping_cart, color: Colors.white, size: 20),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        enableFeedback: true,
        elevation: 5,
        backgroundColor: AppColors.mainColor,
        shape: StadiumBorder(),
        onPressed: () {},
        child: Icon(Icons.mode_comment, color: Colors.white, size: 30),
      ),
      bottomNavigationBar: AppMenu(),
    );
  }
}