import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_hub/domain/dio.dart';
import 'package:food_hub/domain/user.dart';

class MessageResponse {
  bool isSuccessful;
  String message;

  MessageResponse({
    required this.isSuccessful,
    required this.message
  });
}

// Provider para el estado del usuario
class AuthProvider extends ChangeNotifier {

  User? usuario;
  bool isAuthenticated = false;

  Future<MessageResponse> login(String email, String password) async {

    try {
      final response = await DioClient.instance.post('/api/auth/login',
        data: {
          'correo': email,
          'clave': password
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data;
        usuario = User(
          id: data["id_usuario"],
          typeUser: data["tipo_usuario"],
          name: data["nombre"], 
          email: data["correo"], 
          address: data["direccion"],
        );
        isAuthenticated = true;
        // print(response.data);
        notifyListeners();
        return MessageResponse(isSuccessful: true, message: "Usuario autenticado");
      } else {
        usuario = null;
        isAuthenticated = false;
        notifyListeners();
        return MessageResponse(isSuccessful: false, message: "Error en la autenticación");
      }
    }  on DioException catch (e) {
      // print(e.response?.data);
      return MessageResponse(
        isSuccessful: false,
        message: (e.response != null ? e.response?.data["error"] : "Error en la autenticación")
      );
    } catch (e) {
      return MessageResponse(isSuccessful: false, message: "Error inesperado");
    }
  }

  Future<MessageResponse> register(String nombres, String email, String password, String direccion) async {

    try {
      final response = await DioClient.instance.post('/api/auth/register',
        data: {
          'nombre': nombres,
          'tipo_usuario': "USER",
          'correo': email,
          'clave': password,
          'direccion' : direccion
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        usuario = User(
          id: data["id_usuario"],
          typeUser: data["tipo_usuario"],
          name: data["nombre"], 
          email: data["correo"], 
          address: data["direccion"],
        );
        isAuthenticated = true;
        notifyListeners();
        return MessageResponse(isSuccessful: true, message: "Usuario autenticado");
      } else {
        usuario = null;
        isAuthenticated = false;
        notifyListeners();
        return MessageResponse(isSuccessful: true, message: "Error en la autenticación");
      }
    }  on DioException catch (e) {
      return MessageResponse(
        isSuccessful: false,
        message: (e.response != null ? e.response?.data["error"] : "Error en la autenticación")
      );
    } catch (e) {
      return MessageResponse(isSuccessful: false, message: "Error inesperado");
    }
  }

  Future<void> logout() async {
    usuario = null;
    isAuthenticated = false;
    notifyListeners();
  }
}



