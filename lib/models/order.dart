import 'package:flutter/material.dart';

import '../models/cart.dart';

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

  List<Order> get orders {
    return [..._orders];
  }

  void addOrderItem(List<CartItem> cartProducts, double totalAmount) {
    _orders.insert(
      0,
      Order(
          dateTime: DateTime.now(),
          id: DateTime.now().toString(),
          items: cartProducts,
          totalAmount: totalAmount),
    );
  }
}
