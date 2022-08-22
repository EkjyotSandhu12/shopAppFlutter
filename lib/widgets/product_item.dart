import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../models/auth.dart';
import '../models/cart.dart';
import '../models/product.dart';

class ProductItem extends StatelessWidget {

  Widget build(BuildContext context) {
    Product product = Provider.of<Product>(context, listen: false);
    Cart cart = Provider.of<Cart>(context, listen: false);
    Auth auth = Provider.of<Auth>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: GestureDetector(
        onTap: (){
          Navigator.of(context).pushNamed("/ProductDetailsPage", arguments: product.id);
        },
        child: GridTile(
          footer: GridTileBar(
            title: Text(
              product.title,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              textScaleFactor: 0.88,
            ),
            backgroundColor: Theme.of(context).colorScheme.background,
            leading: Consumer<Product>(
              builder: (_, product, child) => IconButton(
                onPressed: () {
                  product.setToggleFavourite(auth.userId, auth.tokenKey);
                },
                icon: product.isFavorite
                    ? const Icon(Icons.favorite_outlined)
                    : const Icon(Icons.favorite_outline_outlined),
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            trailing: IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                cart.addItem(product.id, product.price, product.title);

                SnackBar sb = SnackBar(
                  content: const Text("Item Added To Cart"),
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(
                    label: "Undo",
                    onPressed: (){
                      cart.removeOneQuantity(product.id);
                    },
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(sb);
              },
              icon: const Icon(Icons.shopping_cart),
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
            errorBuilder:
                (BuildContext context, Object exception, StackTrace? stackTrace) {
              return const Text("messy Url");
            },
          ),
        ),
      ),
    );
  }
}
