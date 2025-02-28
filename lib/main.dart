import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_hub/config/env.dart';
import 'package:food_hub/pages/auth/login_page.dart';
import 'package:food_hub/pages/food/cart_page.dart';
import 'package:food_hub/pages/reserva/detalle.dart';
import 'package:food_hub/pages/reserva/historialreserva.dart';
import 'package:food_hub/pages/reserva/resumen.dart';
import 'package:food_hub/pages/reserva/sedes.dart';
import 'package:food_hub/pages/user/admin_reservas.dart';
import 'package:food_hub/pages/user/user_profile_change_password_page.dart';
import 'package:food_hub/providers/auth_provider.dart';
import 'package:food_hub/providers/cart_provider.dart';
import 'package:food_hub/providers/chatbot_provider.dart';
import 'package:food_hub/providers/compra_provider.dart';
import 'package:food_hub/providers/food_provider.dart';
import 'package:food_hub/providers/reserva_provider.dart';
import 'package:food_hub/pages/auth/registro_usuario_page.dart';
import 'package:food_hub/pages/user/admin_compras.dart';
import 'package:food_hub/pages/home/main_food_page.dart';
import 'package:food_hub/pages/home/Inicio1.dart';
import 'package:food_hub/pages/home/Inicio2.dart';
import 'package:food_hub/pages/user/admin_profile_page.dart';
import 'package:food_hub/pages/user/admin_view_page.dart';
import 'package:food_hub/pages/user/user_profile_page.dart';
import 'package:food_hub/providers/shared_provider.dart';
import 'package:food_hub/utils/colors.dart';
import 'package:get/get.dart';
import 'package:food_hub/domain/sede.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Asegura la inicialización
  await Firebase.initializeApp(); // Inicializa Firebase
  await setupRemoteConfig(); // Carga Remote Config antes de iniciar la app
  initializeDateFormatting('es_ES', null); // Inicializa formatos en español
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
        ChangeNotifierProvider(create: (_) => ChatbotProvider()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        initialRoute: '/iniciolog', // Ruta inicial
        routes: {
          '/': (context) => MainFoodPage(),
          '/login': (context) => LoginPage(),
          '/register': (context) => RegistroPage(),
          '/userProfile': (context) => PerfilUsuarioPage(),
          '/adminProfile': (context) => PerfilAdminPage(),
          '/adminView': (context) => VistaAdminPage(),
          '/adminReservas': (context) => AdminReservasPage(),
          '/adminCompras': (context) => AdminComprasPage(),
          '/iniciolog': (context) => const SplashScreen(),
          '/iniciolog2': (context) => const SplashScreen2(),
          '/reserva': (context) => DetallePage(
              sedeSeleccionada:
                  Sede(nombre: '', descripcion: '', direccion: '', imagen: '')),
          '/sedes_reserva': (context) => SedesPage(),
          '/resumen_reserva': (context) {
            final route = ModalRoute.of(context);
            final arguments =
                route?.settings.arguments as Map<String, dynamic>?;

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
          '/historial_reserva': (context) => HistorialReservasPage(),
        },
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.mainColor),
          useMaterial3: true,
        ),
      ),
    );
  }
}
