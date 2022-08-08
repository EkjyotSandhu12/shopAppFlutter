import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/widgets/badge.dart';

import '../models/cart.dart';
import '../widgets/product_item.dart';
import 'cart_page.dart';

bool showFavourite = false;

class ProductOverviewPage extends StatefulWidget {
  @override
  State<ProductOverviewPage> createState() => _ProductOverviewPageState();
}

class _ProductOverviewPageState extends State<ProductOverviewPage> {
  Widget build(BuildContext context) {
    final ProductData = Provider.of<ProductsProvider>(context);
    final products = showFavourite
        ? ProductData.getItems.where((element) => element.isFavorite).toList()
        : ProductData.getItems;
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              setState(() {
                if (value == 1) {
                  showFavourite = true;
                } else {
                  showFavourite = false;
                }
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 1,
                child: Text("Favourites"),
              ),
              const PopupMenuItem(
                value: 0,
                child: Text("All"),
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (ctx, cart, child) => Badge(
              value: cart.itemCount.toString(),
              child: child!,
            ),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartPage.routeName);
              },
            ),
          )
        ],
        title: Text("Shop App"),
      ),
      body: GridView.builder(
        itemCount: products.length,
        padding: EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (_, index) => ChangeNotifierProvider.value(
          value: products[index],
          child: ProductItem(),
        ),
      ),
    );
  }
}
