import 'package:flutter/material.dart';
import 'package:food_hub/utils/colors.dart';
import 'package:food_hub/utils/dimensions.dart';
// import 'package:food_hub/widgets/app_icon.dart';

class AppMenu extends StatefulWidget {

  int selectedIndex;

  AppMenu({super.key, this.selectedIndex = 0});

  @override
  State<AppMenu> createState() => _AppMenuState();
}

class _AppMenuState extends State<AppMenu> {

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    _selectedIndex = widget.selectedIndex;
    _selectedIndex = index;
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/');
        break;
      case 1:
        Navigator.pushNamed(context, '/sedes_reserva');
        break;
      case 2:
        Navigator.pushNamed(context, '/carrito');
        break;
      case 3:
        Navigator.pushNamed(context, '/userProfile');
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
  void initState() {
    super.initState();

    _selectedIndex = widget.selectedIndex;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final rutaActual = ModalRoute.of(context)?.settings.name;

      switch (rutaActual) {
        case '/':
          _selectedIndex = 0;
          break;
        case '/sedes_reserva':
          _selectedIndex = 1;
          break;
        case '/carrito':
          _selectedIndex = 2;
          break;
        case '/userProfile':
          _selectedIndex = 3;
          break;
        // default:
        //   _selectedIndex = 0;
        //   break;
      }
      setState(() {});
  });
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