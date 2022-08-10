import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../models/cart.dart';
import '../models/product.dart';
import '../pages/products_detail_page.dart';
import '../providers/products_provider.dart';

class ProductItem extends StatelessWidget {

  Widget build(BuildContext context) {
    Product product = Provider.of<Product>(context, listen: false);
    Cart cart = Provider.of<Cart>(context, listen: false);
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
              softWrap: true,
              maxLines: 3,
            ),
            backgroundColor: Theme.of(context).colorScheme.background,
            leading: Consumer<Product>(
              builder: (_, product, child) => IconButton(
                onPressed: () {
                  product.setToggleFavourite();
                },
                icon: product.isFavorite
                    ? const Icon(Icons.favorite_outlined)
                    : const Icon(Icons.favorite_outline_outlined),
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            trailing: IconButton(
              onPressed: () {
                cart.addItem(product.id, product.price, product.title);
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
