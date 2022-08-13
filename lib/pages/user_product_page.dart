import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/widgets/user_product_item.dart';

import '../widgets/side_drawer.dart';

class UserProductPage extends StatelessWidget {
  static String routeName = "/UserProductPage";

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductsProvider>(context).getItems;
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Product"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (_, index) => ChangeNotifierProvider.value(
            value: products[index],
            child: UserProductItem(),
          ),
        ),
      ),
      drawer: sideDrawer(),
    );
  }
}
