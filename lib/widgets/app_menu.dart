import 'package:flutter/material.dart';
import 'package:food_hub/utils/colors.dart';
import 'package:food_hub/utils/dimensions.dart';
import 'package:food_hub/widgets/app_icon.dart';

class AppMenu extends StatefulWidget {
  const AppMenu({super.key});

  @override
  State<AppMenu> createState() => _AppMenuState();
}

class _AppMenuState extends State<AppMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: Dimensions.height10,
        bottom: Dimensions.height10,
      ),
      child: 
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            AppIcon(iconSize: Dimensions.iconSize32, iconColor:Colors.white, backgroundColor: AppColors.mainColor, icon: Icons.home),
            AppIcon(iconSize: Dimensions.iconSize32, iconColor:Colors.white, backgroundColor: AppColors.mainColor, icon: Icons.table_bar),
            AppIcon(iconSize: Dimensions.iconSize32, iconColor:Colors.white, backgroundColor: AppColors.mainColor, icon: Icons.shopping_cart),
            AppIcon(iconSize: Dimensions.iconSize32, iconColor:Colors.white, backgroundColor: AppColors.mainColor, icon: Icons.person),
          ],
        ),
    );
  }
}