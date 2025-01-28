import 'package:flutter/material.dart';
import 'package:food_hub/utils/colors.dart';
import 'package:food_hub/utils/dimensions.dart';
import 'package:food_hub/widgets/app_icon.dart';
import 'package:food_hub/widgets/big_text.dart';
import 'package:food_hub/widgets/exandable_text_widget.dart';

class RecommendedFoodDetail extends StatelessWidget {
  const RecommendedFoodDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(icon: Icons.clear),
                AppIcon(icon: Icons.shopping_cart_outlined)
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
            backgroundColor: AppColors.yellowColor,
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
                    text: "Un clasico de la gastronomía peruana. Delicados trozos de pescado fresco, marinados en jugo de limón recién exprimido, acompañados de cebolla roja, ají limo y un toque de cilantro fresco. El ceviche es sin duda el rey de la gastronomía peruana. Amado en nuestro territorio y admirado fuera de él, es un potaje que resulta de la perfecta combinación de los siguientes insumos básicos: el pescado, el limón, la cebolla roja y el ají limo. Más allá de estos ingredientes, admite, por supuesto, muchas variantes en la que intervienen los mariscos, el culantro, distintas proporciones de sal, kion, ajo y hasta el polémico glutamato monosódico. Además, viene con distintos acompañamientos según el lugar en el que se prepare o se coma: choclo sancochado, camote (a veces glaseado), canchita serrana, lechuga, zarandaja y más.... Pero ¿dónde reside el maravilloso encanto del ceviche? ¿En la frescura del pescado? ¿En el acidito del limón? ¿En la potencia de la cebolla cruda? ¿En ese toque picante que imprimen los ajíes peruanos? Pues en el equilibrio de todo lo dicho, y, por supuesto, en la calidad de los insumos. El pescado del mar peruano definitivamente es de carne especialmente sabrosa por la abundancia de plancton que favorece su nutrición. El limón sutil peruano tiene características propias y aporta una frescura ácida inigualable. Nuestras cebollas imprimen un sabor marcado e intenso. El limo es un ají único que no solo aporta picor, sino también un aroma que estimula nuestros sentidos."
                  ),
                )
              ],
            )
          )
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: Dimensions.width20*2.5,
              right: Dimensions.width20*2.5,
              top: Dimensions.height10,
              bottom: Dimensions.height10,
            ),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppIcon(iconSize: Dimensions.iconSize24, iconColor:Colors.white, backgroundColor: AppColors.mainColor, icon: Icons.remove),
              BigText(text: "S/. 56 X 0", color: AppColors.mainBlackColor,size:Dimensions.font26),
              AppIcon(iconSize: Dimensions.iconSize24, iconColor:Colors.white, backgroundColor: AppColors.mainColor, icon: Icons.add)
            ],
          ),
          )
        ],
      ),
    );
  }
}

