import 'package:flutter/material.dart';
import 'package:food_hub/utils/colors.dart';
import 'package:food_hub/utils/dimensions.dart';
// import 'package:food_hub/widgets/app_icon.dart';

class AppMenu extends StatefulWidget {
  const AppMenu({super.key});

  @override
  State<AppMenu> createState() => _AppMenuState();
}

class _AppMenuState extends State<AppMenu> {

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    _selectedIndex = index;
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/');
        break;
      case 1:
        Navigator.pushNamed(context, '/second');
        break;
      default:
        Navigator.pushNamed(context, '/');
        break;
    }
    // setState(() {
    //   _selectedIndex = index;
    // });
  }

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
          children: [ // Botones del menú
            ElevatedButton(
              onPressed:() {
                _selectedIndex = 0;
                _onItemTapped(_selectedIndex);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: (_selectedIndex==0) ? AppColors.btnSelectColor : AppColors.mainColor, // Color de fondo
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Bordes redondeados
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10), // Espaciado interno
              ),
              child: Icon(Icons.home, color: Colors.white, size: 30),
            ),
            ElevatedButton(
              onPressed: () {
                _selectedIndex = 1;
                _onItemTapped(_selectedIndex);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: (_selectedIndex==1) ? AppColors.btnSelectColor : AppColors.mainColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Bordes redondeados
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10), // Espaciado interno
              ),
              child: Icon(Icons.table_bar, color: Colors.white, size: 30),
            ),
            ElevatedButton(
              onPressed: () {
                _selectedIndex = 2;
                _onItemTapped(_selectedIndex);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: (_selectedIndex==2) ? AppColors.btnSelectColor : AppColors.mainColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Bordes redondeados
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10), // Espaciado interno
              ),
              child: Icon(Icons.shopping_cart, color: Colors.white, size: 30),
            ),
            ElevatedButton(
              onPressed: () {
                _selectedIndex = 3;
                _onItemTapped(_selectedIndex);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: (_selectedIndex==3) ? AppColors.btnSelectColor : AppColors.mainColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Bordes redondeados
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10), // Espaciado interno
              ),
              child: Icon(Icons.person, color: Colors.white, size: 30),
            ),
          ],
        ),
    );
  }
}