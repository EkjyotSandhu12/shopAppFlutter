import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../models/cart.dart';
import '../providers/products_provider.dart';

class CartItem extends StatelessWidget {
  String title;
  String productId;
  String cartId;
  int quantity;
  double price;

  CartItem(
      {required this.title,
      required this.cartId,
      required this.quantity,
      required this.price,
      required this.productId});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductsProvider>(context);
    final cart = Provider.of<Cart>(context);
    return Card(
      elevation: 2,
      color: Theme.of(context).colorScheme.secondary,
      child: ListTile(
        title: Text(title,
            style: TextStyle(color: Colors.white, height: 1),
            maxLines: 1,
            softWrap: true),
        leading: Container(
          height: double.infinity,
          width: 100,
          child: Image.network(
            product.getImage(productId),
            fit: BoxFit.cover,
            errorBuilder: (BuildContext context, Object exception,
                StackTrace? stackTrace) {
              return const Text("messy Url");
            },
          ),
        ),
        subtitle: Row(
          children: [
            Text("x$quantity", style: TextStyle(color: Colors.white)),
            TextButton(
              onPressed: () {
                cart.removeQuantity = cartId;
                print(cartId);
              },
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
              ),
              child: const Text(
                "-",
                style: TextStyle(fontSize: 20, color: Colors.red),
              ),
            )
          ],
        ),
        trailing: Text("Total: ₹ ${(price * quantity).toStringAsFixed(2)}",
            style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
