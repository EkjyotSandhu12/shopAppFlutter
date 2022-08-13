import 'dart:ui';

import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String productId;
  final String title;
  int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.productId, // we are using this to find the cartItem in the list
    required this.title,
    required this.quantity,
    required this.price,
  });
}

class Cart with ChangeNotifier {
  List<CartItem> _items = [];

  List<CartItem> get items {
    return [..._items];
  }

  set removeQuantity(String cartId){

    final selectedCartItem = _items.firstWhere((element) => element.id == cartId);
    selectedCartItem.quantity--;
    if(selectedCartItem.quantity == 0){
      removeCartItem = selectedCartItem;
    }
    notifyListeners();
  }

  set removeCartItem(CartItem object){
    _items.remove(object);
    notifyListeners();
  }

  int get itemCount {
    return _items.length;
  }

  double get totalSum{
    double total = 0.0;
    _items.forEach((element) { total += element.price * element.quantity; });
    return total;
  }

  void emptyCart(){
    _items.clear();
    notifyListeners();
  }

  void removeOneQuantity(String id){
    final cartItem = _items.firstWhere((element) => element.productId == id);
    if(cartItem.quantity == 1) {
      removeCartItem = cartItem;
    }else{
      cartItem.quantity--;
    }
  }

  void addItem(
    String productId,
    double price,
    String title,
  ) {
    final item = _items.firstWhere((element) => element.productId == productId,
        orElse: () {
      return CartItem(
          id: DateTime.now().toString(),
          productId: productId,
          title: title,
          quantity: 1,
          price: price);
    });

    if(_items.contains(item)){
      item.quantity++;
    }else{
      _items.add(item);
      notifyListeners();
    }
  }
}
