import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/order_item.dart';

import '../models/order.dart';
import '../widgets/side_drawer.dart';

class OrderPage extends StatelessWidget {
  static String routeName = "/OrderPage";

  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            ...orderData.orders.map(
              (e) => OrderItem(orderItem: e),
            ).toList(),
          ],
        ),
      ),
      drawer: sideDrawer(),
    );
  }
}
