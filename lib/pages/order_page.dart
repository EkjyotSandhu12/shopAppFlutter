import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;
import 'package:shop_app/widgets/order_item.dart';

import '../models/order.dart';
import '../widgets/side_drawer.dart';

class OrderPage extends StatefulWidget {
  static String routeName = "/OrderPage";

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
            future: provider.Provider.of<Orders>(context, listen: false).fetchOrder(),
            builder: (ctx, snapShot) {
              if (snapShot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapShot.error != null) {
                return Center(child: Text("Something went wrong..."));
              } else {
                return provider.Consumer<Orders>(
                  builder: (context, orderData, child) {
                    return orderData.orders.isEmpty? Center(child: Text("No Orders Placed..")) : ListView(
                      children: [
                        ...orderData.orders
                            .map(
                              (e) => OrderItem(orderItem: e),
                            )
                            .toList(),
                      ],
                    );
                  }
                );
              }
            }),
      ),
      drawer: sideDrawer(),
    );
  }
}
