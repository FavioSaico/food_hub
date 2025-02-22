import 'package:flutter/material.dart';
import 'package:food_hub/pages/auth/login_page.dart';
import 'package:food_hub/pages/food/cart_page.dart';
import 'package:food_hub/pages/reserva/detalle.dart';
import 'package:food_hub/pages/reserva/resumen.dart';
import 'package:food_hub/pages/reserva/sedes.dart';
import 'package:food_hub/pages/user/admin_reservas.dart';
import 'package:food_hub/pages/user/user_profile_change_password_page.dart';
import 'package:food_hub/providers/auth_provider.dart';
import 'package:food_hub/providers/cart_provider.dart';
import 'package:food_hub/providers/compra_provider.dart';
import 'package:food_hub/providers/food_provider.dart';
import 'package:food_hub/providers/reserva_provider.dart';
import 'package:food_hub/pages/auth/registro_usuario_page.dart';
import 'package:food_hub/pages/user/admin_compras.dart';

import 'package:food_hub/pages/home/main_food_page.dart';

import 'package:food_hub/pages/pago/RegisterCard.dart';
import 'package:food_hub/pages/home/Inicio1.dart';
import 'package:food_hub/pages/home/Inicio2.dart';
import 'package:food_hub/pages/user/admin_profile_page.dart';
import 'package:food_hub/pages/user/admin_view_page.dart';
import 'package:food_hub/pages/user/user_profile_page.dart';

import 'package:food_hub/pages/pago/compra.dart';
import 'package:food_hub/pages/pago/Pagorealizado.dart';
import 'package:food_hub/pages/pago/compratienda.dart';

import 'package:food_hub/pages/pago/detalle.dart';
import 'package:food_hub/pages/reserva/detallenuevo.dart';
import 'package:food_hub/providers/shared_provider.dart';
import 'package:get/get.dart';

import 'package:food_hub/domain/sede.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FoodProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => SharedProvider()),
        ChangeNotifierProvider(create: (_) => CompraProvider()),
        ChangeNotifierProvider(create: (_) => ReserveProvider()),
        ChangeNotifierProvider(create: (_) => CompraProvider()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        initialRoute: '/DetalleReservas', // Ruta inicial
        routes: {
          '/': (context) => MainFoodPage(),
          '/login': (context) => LoginPage(),
          '/register': (context) => RegistroPage(),
          '/userProfile': (context) => PerfilUsuarioPage(),
          '/adminProfile': (context) => PerfilAdminPage(),
          '/adminView': (context) => VistaAdminPage(),
          '/adminReservas': (context) => AdminReservasPage(),
          '/adminCompras': (context) => AdminComprasPage(),

          // '/register-card': (context) => const RegisterCard(),
          '/iniciolog': (context) => const SplashScreen(),
          '/iniciolog2': (context) => const SplashScreen2(),
          '/DetalleCompra': (context)=>DetalleCompraScreen(),
          '/DetalleReservas':(context)=>DetalleReservaScreen(),
          '/reserva': (context) => DetallePage(
              sedeSeleccionada:
                  Sede(nombre: '', descripcion: '', direccion: '', imagen: '')),
          '/sedes_reserva': (context) => SedesPage(),
          '/resumen_reserva': (context) {
            final arguments = ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>;
            return ResumenPage(
              sede: arguments?['sede'] as Sede? ??
                  Sede(nombre: '', descripcion: '', direccion: '', imagen: ''),
              requerimientos: arguments?['requerimientos'] as String? ?? "",
              fechaHora: arguments?['fechaHora'],
              cantidadPersonas: arguments?['cantidadPersonas'] as int? ?? 1,
              zonaPreferida: arguments?['zonaPreferida'] as String? ?? "",
            );
          },
          '/cambio_contraseña': (context) => CambiarContrasenaPage(),
          '/carrito': (context) => CartPage(),
          // '/pagoefectuado':(context)=> const PaymentScreen(),
          '/pagoefectuadotienda': (context) => const PaymentScreen2(),
          // '/pagorealizado':(context)=>const PagoRealizadoPage(numeroCompra: 3, monto: 168.00)
        },
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    );
  }
}
