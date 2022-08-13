import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cart.dart';
import '../models/order.dart';
import '../widgets/cart_item.dart' as cartWidget;

class CartPage extends StatelessWidget {
  static String routeName = '/Cartpage';

  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    final list = cart.items;
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text("Total"),
                    Spacer(flex: 10),
                    Chip(
                        label: Text(
                          "₹ ${cart.totalSum.toStringAsFixed(2)}",
                          style: Theme.of(context).primaryTextTheme.headline1,
                        ),
                        backgroundColor: Theme.of(context).colorScheme.primary),
                    Spacer(),
                    TextButton(
                        onPressed: () {
                          Provider.of<Orders>(context, listen: false)
                              .addOrderItem(list, cart.totalSum);
                          cart.emptyCart();
                        },
                        child: Text(" ORDER ")),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                child: ListView.builder(
                  itemCount: cart.itemCount,
                  itemBuilder: (_, index) => Dismissible(
                    confirmDismiss: (DismissDirection) {
                      return showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text("Are you Sure?"),
                          content: Text("LIKIE SURE? SURE?"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop(true);
                                },
                                child: Text("yes")),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop(false);
                                },
                                child: Text("no")),
                          ],
                        ),
                      );
                    },
                    onDismissed: (_) {
                      cart.removeCartItem = list[index];
                    },
                    direction: DismissDirection.endToStart,
                    key: ValueKey(list[index].id),
                    background: Container(
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(5)),
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: const Icon(Icons.delete_forever),
                    ),
                    child: cartWidget.CartItem(
                      cartId: list[index].id,
                      title: list[index].title,
                      price: list[index].price,
                      productId: list[index].productId,
                      quantity: list[index].quantity,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
