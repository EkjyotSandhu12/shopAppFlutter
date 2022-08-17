import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'http_url.dart';

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

  set removeQuantity(String cartId) {
    final selectedCartItem =
        _items.firstWhere((element) => element.id == cartId);
    selectedCartItem.quantity--;
    if (selectedCartItem.quantity == 0) {
      removeCartItem(selectedCartItem);
    }
    notifyListeners();
  }

    removeCartItem(CartItem object)  {
     http.delete(Uri.parse(HttpUrl.cartUrl + "/${object.id}.json"));
    _items.remove(object);
    notifyListeners();
  }

  int get itemCount {
    return _items.length;
  }

  double get totalSum {
    double total = 0.0;
    _items.forEach((element) {
      total += element.price * element.quantity;
    });
    return total;
  }

  Future<void> emptyCart() async {

    await http.delete(Uri.parse(HttpUrl.cartUrl + ".json"));

    _items.clear();
    notifyListeners();
  }

  void removeOneQuantity(String id) {
    final cartItem = _items.firstWhere((element) => element.productId == id);
    if (cartItem.quantity == 1) {
      removeCartItem(cartItem);
    } else {
      cartItem.quantity--;
      http.patch(Uri.parse(HttpUrl.cartUrl + "/${id}.json"),
          body: json.encode({
            'quantity': cartItem.quantity,
          }));
    }
  }

  Future<void> fetchCart() async {

    List<CartItem> fetchedList = [];

    final respose = await http.get(Uri.parse(HttpUrl.cartUrl + ".json"));

    if(respose.body == "null") return;

    final fetchedData = json.decode(respose.body) as Map<String, dynamic>;



    fetchedData.forEach((key, value) {
      fetchedList.add(CartItem(
          id: key,
          productId: value['productId'],
          title: value['title'],
          quantity: value['quantity'],
          price: value['price']));
    });

    _items = fetchedList;
    notifyListeners();
  }

  void addItem(
    String productId,
    double price,
    String title,
  ) {
    final item = _items.firstWhere((element) => element.productId == productId,
        orElse: () {
      return CartItem(
          id: "",
          productId: productId,
          title: title,
          quantity: 1,
          price: price);
    });

    if (_items.contains(item)) {
      item.quantity++;
      http.patch(Uri.parse(HttpUrl.cartUrl + "/${item.id}.json"),
          body: json.encode({'quantity': item.quantity}));
    } else {
      _items.add(item);
      http.post(Uri.parse(HttpUrl.cartUrl + ".json"),
          body: json.encode({
            'productId': item.productId,
            'title': item.title,
            'quantity': item.quantity,
            'price': item.price,
          }));

      notifyListeners();
    }
  }
}
