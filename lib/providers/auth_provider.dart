import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_hub/domain/dio.dart';
import 'package:food_hub/domain/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  User? get currentUser => usuario; // Getter para obtener el usuario actual

  // GUARDAR LOS DATOS DEL USUARIOS EN EL DISPOSITIVO
  Future<void> saveUserSession(User? usuario) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt('id', usuario!.id);
    await prefs.setString('name', usuario.name);
    await prefs.setString('typeUser',usuario.typeUser);
    await prefs.setString('email', usuario.email);
    await prefs.setString('address', usuario.address);
  }
  // OBTENER LOS DATOS DEL USUARIO DEL DISPOSITIVO
  Future<void> getUserSesion() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userEmailJson = prefs.getString('email');

    if (userEmailJson != null) {
      usuario = User(
        id: prefs.getInt('id') ?? 1,
        typeUser: prefs.getString('typeUser') ?? "",
        name: prefs.getString('name') ?? "", 
        email: userEmailJson, 
        address: prefs.getString('address') ?? "",
      );
    }else{
      usuario = null;
    }
    notifyListeners();
  }

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
        
        await saveUserSession(usuario);
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

        await saveUserSession(usuario);

        notifyListeners();
        return MessageResponse(isSuccessful: true, message: "Usuario registrado");
      } else {
        usuario = null;
        isAuthenticated = false;
        notifyListeners();
        return MessageResponse(isSuccessful: true, message: "Error en el registro");
      }
    }  on DioException catch (e) {
      return MessageResponse(
        isSuccessful: false,
        message: (e.response != null ? e.response?.data["error"] : "Error en el registro")
      );
    } catch (e) {
      return MessageResponse(isSuccessful: false, message: "Error inesperado");
    }
  }
  
  Future<MessageResponse> changePassword(int userId, String oldPassword, String newPassword) async {
  try {
    final response = await DioClient.instance.put('/api/auth/changepassword',
      data: {
        'id_usuario': userId,
        'clave_actual': oldPassword,
        'clave_nueva': newPassword,
      },
    );

    if (response.statusCode == 200) {
      return MessageResponse(isSuccessful: true, message: "Contraseña cambiada con éxito");
    } else {
      return MessageResponse(isSuccessful: false, message: "Error al cambiar la contraseña");
    }
  } on DioException catch (e) {
    return MessageResponse(
      isSuccessful: false,
      message: (e.response != null ? e.response?.data["error"] : "Error al cambiar la contraseña"),
    );
  } catch (e) {
    return MessageResponse(isSuccessful: false, message: "Error inesperado");
  }
}

  Future<void> logout() async {
    usuario = null;
    isAuthenticated = false;

    // Eliminar usuario al cerrar sesión
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('id');
    await prefs.remove('name');
    await prefs.remove('typeUser'); 
    await prefs.remove('email');
    await prefs.remove('address'); 

    notifyListeners();
  }
}



