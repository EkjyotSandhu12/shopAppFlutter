import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/pages/AddOrEdit_product_page.dart';
import 'package:shop_app/providers/products_provider.dart';

import '../models/cart.dart';
import '../models/product.dart';

class UserProductItem extends StatelessWidget {
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final product = Provider.of<Product>(context);
    final products = Provider.of<ProductsProvider>(context);
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(product.imageUrl)),
      title: Text(product.title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
                Navigator.of(context).pushNamed(AddOrEditProductPage.routeName, arguments: product);
            },
            icon: Icon(Icons.edit),
            color: Colors.blueGrey,
          ),
          IconButton(
              onPressed: () {
                products.deleteProduct = product;
                cart.removeCartItem = cart.items.firstWhere((element) => element.productId == product.id);
              },
              icon: Icon(Icons.delete_forever),
              color: Theme.of(context).errorColor),
        ],
      ),
    );
  }
}
