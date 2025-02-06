
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_hub/domain/dio.dart';
import 'package:food_hub/domain/food.dart';

class FoodProvider extends ChangeNotifier {

  // lista de comidas
  List<Food> foodList = [];

  Future<void> getFoods() async {

    try {
      await Future.delayed(const Duration(milliseconds: 1000));

      final response = await DioClient.instance.get('/api/food');
      // Mapper
      if (response.statusCode == 200) {
        List<Food> lista = [];
        final data = (response.data as List);
        for (var i = 0; i < data.length; i++) {
          Food currentFood = Food(
            id: data[i]["id_comida"], 
            name: data[i]["comida"], 
            description: data[i]["descripcion"], 
            price: double.parse(data[i]["precio"].toString()), 
            imageUrl: data[i]["imagen"], 
            typeFood: data[i]["tipo_comida"], 
            time: data[i]["tiempo"]
          );
          lista.add(currentFood);
        }
        foodList = lista;
        notifyListeners(); 
      }
    }  on DioException catch (e) {
      print(e);
      // return MessageResponse(
      //   isSuccessful: false,
      //   message: (e.response != null ? e.response?.data["error"] : "Error en la autenticación")
      // );
    } catch (e) {
      print(e);
      // return MessageResponse(isSuccessful: false, message: "Error inesperado");
    }
  }
  
}