import 'package:flutter/material.dart';
import 'package:food_hub/providers/auth_provider.dart';
import 'package:food_hub/utils/colors.dart';
import 'package:food_hub/utils/dimensions.dart';
import 'package:provider/provider.dart';


class AppMenu extends StatefulWidget {
  final int selectedIndex;

  const AppMenu({super.key, this.selectedIndex = 0});

  @override
  State<AppMenu> createState() => _AppMenuState();
}

class _AppMenuState extends State<AppMenu> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
    _syncSelectedIndexWithRoute();
  }

  void _syncSelectedIndexWithRoute() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return; // Verifica si el widget está montado
      final rutaActual = ModalRoute.of(context)?.settings.name;
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      setState(() {
        _selectedIndex = _getIndexForRoute(
            rutaActual, authProvider.currentUser?.typeUser == 'ADMIN');
      });
    });
  }

  int _getIndexForRoute(String? route, bool isAdmin) {
    if (isAdmin) {
      switch (route) {
        case '/adminView':
          return 0;
        case '/adminReservas':
          return 1;
        case '/adminCompras':
          return 2;
        case '/adminProfile':
          return 3;
        default:
          return _selectedIndex;
      }
    } else {
      switch (route) {
        case '/':
          return 0;
        case '/sedes_reserva':
          return 1;
        case '/carrito':
          return 2;
        case '/userProfile':
          return 3;
        default:
          return _selectedIndex;
      }
    }
  }

  void _onItemTapped(int index) {
    if (!mounted) return;
    setState(() => _selectedIndex = index);

    final auth = context.read<AuthProvider>();
    final routes =
        auth.currentUser?.typeUser == 'ADMIN' ? _adminRoutes : _userRoutes;

    Navigator.pushNamed(context, routes[index]!);
  }

  final _adminRoutes = {
    0: '/adminView',
    1: '/adminReservas',
    2: '/adminCompras',
    3: '/adminProfile',
  };

  final _userRoutes = {
    0: '/',
    1: '/sedes_reserva',
    2: '/carrito',
    3: '/userProfile',
  };

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        return Container(
          margin: EdgeInsets.only(
            top: Dimensions.height10,
            bottom: Dimensions.height10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: auth.currentUser?.typeUser == 'ADMIN'
                ? _buildAdminButtons() 
                : _buildUserButtons(),
          ),
        );
      },
    );
  }

  List<Widget> _buildAdminButtons() {
    return [
      _buildButton(0, Icons.dashboard, 'Panel'),
      _buildButton(1, Icons.calendar_today, 'Reservas'),
      _buildButton(2, Icons.shopping_bag, 'Compras'),
      _buildButton(3, Icons.admin_panel_settings, 'Perfil'),
    ];
  }

  List<Widget> _buildUserButtons() {
    return [
      _buildButton(0, Icons.home, 'Inicio'),
      _buildButton(1, Icons.table_restaurant, 'Reservas'),
      _buildButton(2, Icons.shopping_cart, 'Carrito'),
      _buildButton(3, Icons.person, 'Perfil'),
    ];
  }

  Widget _buildButton(int index, IconData icon, String tooltip) {
    return ElevatedButton(
      onPressed: () {
        _selectedIndex = index;
        _onItemTapped(_selectedIndex);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: (_selectedIndex == index)
            ? AppColors.btnSelectColor
            : AppColors.mainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      ),
      child: Icon(icon, color: Colors.white, size: 30),
    );
  }
}
