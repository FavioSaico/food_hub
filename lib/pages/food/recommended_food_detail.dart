import 'package:flutter/material.dart';
import 'package:food_hub/utils/colors.dart';
import 'package:food_hub/utils/dimensions.dart';
import 'package:food_hub/widgets/app_icon.dart';
import 'package:food_hub/widgets/app_menu.dart';
import 'package:food_hub/widgets/big_text.dart';
import 'package:food_hub/widgets/exandable_text_widget.dart';

class RecommendedFoodDetail extends StatelessWidget {
  const RecommendedFoodDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: (){
                    Navigator.pop(context); // Retrocede
                  },
                  color: Colors.white,
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.mainColor,
                  ),
                  icon: Icon(Icons.chevron_left)
                )
                // AppIcon(icon: Icons.chevron_left, iconColor:Colors.white, backgroundColor: AppColors.mainColor,iconSize: Dimensions.iconSize24),
                // AppIcon(icon: Icons.shopping_cart_outlined)
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20), 
              child: Container(
                // margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5, bottom: 10),
                // color: Colors.white,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20),
                    topRight: Radius.circular(Dimensions.radius20),
                  )
                ),
                child: Center(child: BigText(size: Dimensions.font26, text: "Ceviche de Pescado"),),
              )
            ),
            pinned: true,
            backgroundColor: AppColors.mainColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                "assets/imagenes/Ceviche_Pescado.png",
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
                    text: "Un clasico de la gastronomía peruana. Delicados trozos de pescado fresco, marinados en jugo de limón recién exprimido. El limón sutil peruano tiene características propias y aporta una frescura ácida inigualable. Nuestras cebollas imprimen un sabor marcado e intenso."
                  ),
                )
              ],
            )
          )
        ],
      ),
      // CHATBOT
      floatingActionButton: FloatingActionButton(
        enableFeedback: true, // para que no produzca una pequeña vibración
        elevation: 5, // controlamos las sombras
        backgroundColor: AppColors.mainColor,
        shape: StadiumBorder(),
        onPressed: ( ) {},
        child: Icon(Icons.mode_comment, color: Colors.white, size: 30), // pasamos el icono
      ),
      bottomNavigationBar: AppMenu(),
      // bottomNavigationBar: Column(
      //   mainAxisSize: MainAxisSize.min,
      //   children: [
      //     Container(
      //       padding: EdgeInsets.only(
      //         left: Dimensions.width20*2.5,
      //         right: Dimensions.width20*2.5,
      //         top: Dimensions.height10,
      //         bottom: Dimensions.height10,
      //       ),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           AppIcon(iconSize: Dimensions.iconSize24, iconColor:Colors.white, backgroundColor: AppColors.mainColor, icon: Icons.remove),
      //           BigText(text: "1", color: AppColors.mainBlackColor,size:Dimensions.font26),
      //           AppIcon(iconSize: Dimensions.iconSize24, iconColor:Colors.white, backgroundColor: AppColors.mainColor, icon: Icons.add),
      //           Container(
      //             padding: EdgeInsets.only(
      //               left: Dimensions.width20*2,
      //               right: Dimensions.width20*2,
      //               top: Dimensions.height10,
      //               bottom: Dimensions.height10,
      //             ),
      //             decoration: BoxDecoration(
      //               color: AppColors.mainColor,
      //               borderRadius: BorderRadius.only(
      //                 topLeft: Radius.circular(Dimensions.radius15),
      //                 topRight: Radius.circular(Dimensions.radius15),
      //                 bottomLeft: Radius.circular(Dimensions.radius15),
      //                 bottomRight: Radius.circular(Dimensions.radius15),
      //               )
      //             ),
      //             child: BigText(text: "Añadir", color: Colors.white,size:Dimensions.font16),
      //           ),
      //           Container(
      //             margin: EdgeInsets.only(
      //               left: Dimensions.width20*1.4,
      //             ),
      //             decoration: BoxDecoration(
      //               color: AppColors.mainColor,
      //               borderRadius: BorderRadius.only(
      //                 topLeft: Radius.circular(Dimensions.radius15),
      //                 topRight: Radius.circular(Dimensions.radius15),
      //                 bottomLeft: Radius.circular(Dimensions.radius15),
      //                 bottomRight: Radius.circular(Dimensions.radius15),
      //               )
      //             ),
      //             child:  AppIcon(iconSize: Dimensions.iconSize32, iconColor:Colors.white, backgroundColor: AppColors.mainColor, icon: Icons.mode_comment),
      //           ),
      //         ],
      //       ),
      //     ),
      //     Container(
      //       margin: EdgeInsets.only(
      //         top: Dimensions.height10,
      //         bottom: Dimensions.height10,
      //       ),
      //       child: 
      //         Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceAround,
      //           children: [
      //             AppIcon(iconSize: Dimensions.iconSize32, iconColor:Colors.white, backgroundColor: AppColors.mainColor, icon: Icons.home),
      //             AppIcon(iconSize: Dimensions.iconSize32, iconColor:Colors.white, backgroundColor: AppColors.mainColor, icon: Icons.table_bar),
      //             AppIcon(iconSize: Dimensions.iconSize32, iconColor:Colors.white, backgroundColor: AppColors.mainColor, icon: Icons.shopping_cart),
      //             AppIcon(iconSize: Dimensions.iconSize32, iconColor:Colors.white, backgroundColor: AppColors.mainColor, icon: Icons.person),
      //           ],
      //         ),
      //     )
      //   ],
      // ),
    );
  }
}

