import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/pages/AddOrEdit_product_page.dart';
import 'package:shop_app/providers/products_provider.dart';

import '../models/cart.dart';
import '../models/product.dart';

class UserProductItem extends StatefulWidget {
  @override
  State<UserProductItem> createState() => _UserProductItemState();
}

class _UserProductItemState extends State<UserProductItem> {
  bool deleting = false;

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
              Navigator.of(context).pushNamed(AddOrEditProductPage.routeName,
                  arguments: product);
            },
            icon: Icon(Icons.edit),
            color: Colors.blueGrey,
          ),
          IconButton(
              onPressed: () async {
                setState(() {
                  deleting = true;
                });
                try {

                  final findProductInCart = cart.items.where((element) => element.productId == product.id);

                  if (!findProductInCart.isEmpty) {
                   await cart.removeCartItem(cart.items.firstWhere(
                        (element) => element.productId == product.id));
                  }
                  await products.deleteProduct(product);
                  deleting = false;
                } on Exception catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      duration: Duration(seconds: 1),
                      content: Text(e.toString())));
                  setState(() {
                    deleting = false;
                  });
                }
              },
              icon: deleting
                  ? CircularProgressIndicator()
                  : Icon(Icons.delete_forever),
              color: Theme.of(context).errorColor),
        ],
      ),
    );
  }
}
