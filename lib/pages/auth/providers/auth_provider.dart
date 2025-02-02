import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

// Modelo del usuario
class User {
  final String email;
  final String token;

  User({required this.email, required this.token});
}

final dio = Dio(
  BaseOptions(
    baseUrl: "http://10.0.2.2:3000",
  )
);

// Provider para el estado del usuario
class AuthNotifier extends StateNotifier<User?> {
  AuthNotifier() : super(null);

  Future<void> login(String email, String password) async {
    final response = await dio.post('/api/auth/login',
      data: {
        'correo': email,
        'password': password
      },
    );

    if (response.statusCode == 200) {
      // final data = jsonDecode(response.data);
      // final token = data['token'];
      print(response.data);
      // state = User(email: data['email'], token: 'token'); // Actualiza el estado

      // Guardar en SharedPreferences
      // final prefs = await SharedPreferences.getInstance();
      // await prefs.setString('token', 'UsuarioLogeado');
    } else {
      print('Error en el login');
      // throw Exception('Error en el login');
    }
  }

  Future<void> register(String nombres, String email, String password, String direccion) async {
    final response = await dio.post('/api/auth/register',
      data: {
        'nombres': nombres,
        'direccion': direccion,
        'correo': email,
        'password': password
      },
    );
    print(response.data);
    // if (response.statusCode == 200) {
    //  final data = jsonDecode(response.data);
    //   print(response.data);
    // } else {
    //   print('Error en el registro');
    // }
  }

  Future<void> logout() async {
    state = null; // Borra el estado
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}

// Provider global del usuario
final authProvider = StateNotifierProvider<AuthNotifier, User?>((ref) => AuthNotifier());
