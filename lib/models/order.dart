import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/http_url.dart';

import '../models/cart.dart';
import 'auth.dart';

class Order {
  String id;
  DateTime dateTime;
  double totalAmount;
  List<CartItem> items;

  Order({
    required this.dateTime,
    required this.id,
    required this.items,
    required this.totalAmount,
  });
}

class Orders with ChangeNotifier {
  List<Order> _orders = [];

  final Auth authObject;

  Orders(this.authObject);

  List<Order> get orders {
    return [..._orders];
  }

  Future<void> fetchOrder() async {

    List<Order> fetchedList = [];
    try {
    final url = HttpUrl.orderUrl + '.json?auth=${authObject.tokenKey}&orderBy="userId"&equalTo="${authObject.userId}"';

    final response = await http.get(Uri.parse(url));

      final responseData = json.decode(response.body) == null ? {} : json.decode(response.body) as Map;

      responseData.forEach((key, value) {
        fetchedList.add(Order(
          id: key,
          dateTime: DateTime.parse(value['dateTime']),
          totalAmount: value['totalAmount'],
          items: (value['cartItems'] as List).map((e) {
            return CartItem(
                id: e['id'],
                productId: e['productId'],
                title: e['title'],
                quantity: e['quantity'],
                price: e['price']);
          }).toList(),
        ));
      });
    } finally {
      _orders = fetchedList;
      notifyListeners();
    }


  }

  Future<void> addOrderItem(List<CartItem> cartProducts, double totalAmount) {
    final url = HttpUrl.orderUrl;

    List<Map<String, dynamic>> cartItems = [];

    for (int i = 0; i < cartProducts.length; i++) {
      Map<String, dynamic> item = {};
      item['productId'] = cartProducts[i].productId;
      item['title'] = cartProducts[i].title;
      item['quantity'] = cartProducts[i].quantity;
      item['price'] = cartProducts[i].price;
      item['id'] = cartProducts[i].id;
      cartItems.add(item);
    }

    Map<String, dynamic> productMap = {};
    return http.post(Uri.parse(url + ".json?auth=${authObject.tokenKey}"),
        body: json.encode({
          'userId' : authObject.userId,
          'dateTime': DateTime.now().toIso8601String(),
          'totalAmount': totalAmount,
          'cartItems': cartItems
        }));

  /*  _orders.insert(
      0,
      Order(
          dateTime: DateTime.now(),
          id: DateTime.now().toString(),
          items: cartProducts,
          totalAmount: totalAmount),
    );*/
  }
}
