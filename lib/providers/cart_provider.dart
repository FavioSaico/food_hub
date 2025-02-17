import 'package:flutter/foundation.dart';
import '../domain/cart_item.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> _items = [];
  List<CartItem> get items => [..._items];

  double get subtotal {
    return _items.fold(0, (sum, item) => sum + (item.costo * item.cantidad));
  }
  
  void addItem(CartItem newItem) {
    final existingItemIndex = _items.indexWhere((item) => item.idComida == newItem.idComida);

    if (existingItemIndex >= 0) { // existe
      // _items[existingItemIndex].cantidad += newItem.cantidad;
      if(newItem.cantidad > _items[existingItemIndex].cantidad){
        _items[existingItemIndex].cantidad = newItem.cantidad;
      }
    } else {
      _items.add(newItem);
    }
    


    notifyListeners();
  }

  void updateQuantity(int id, int quantity) {
    if (quantity <= 0) {
      removeItem(id);
      return;
    }

    final itemIndex = _items.indexWhere((item) => item.idComida == id);
    if (itemIndex >= 0) {
      _items[itemIndex].cantidad = quantity;
      notifyListeners();
    }
  }

  void removeItem(int id) {
    _items.removeWhere((item) => item.idComida == id);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}