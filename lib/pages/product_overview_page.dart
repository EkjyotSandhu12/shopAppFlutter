import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/random_data_generator.dart';
import 'package:shop_app/widgets/badge.dart';
import 'package:shop_app/widgets/side_drawer.dart';

import '../models/cart.dart';
import '../models/product.dart';
import '../widgets/product_item.dart';
import 'cart_page.dart';

bool showFavourite = false;

class ProductOverviewPage extends StatefulWidget {
  static String routeName = "/ProductOverviewPage";

  @override
  State<ProductOverviewPage> createState() => _ProductOverviewPageState();
}

class _ProductOverviewPageState extends State<ProductOverviewPage> {
  bool dataLoaded = false;

  @override
  void initState() {
    Provider.of<Cart>(context, listen: false).fetchCart();
    Provider.of<ProductsProvider>(context, listen: false)
        .fetchItems()
        .then((_) {
      dataLoaded = true;
    }).catchError((_) {
      setState(() {
        dataLoaded = true;
      });
    });
  }

  Widget build(BuildContext context) {
    final ProductData = Provider.of<ProductsProvider>(context);
    final products = showFavourite
        ? ProductData.getItems.where((element) => element.isFavorite).toList()
        : ProductData.getItems;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              for (int i = 0; i < 4; i++) {
                ProductData.addProduct(Product(
                  id: (Random().nextInt(123456) + Random().nextInt(123456))
                      .toString(),
                  title: RandomData.randomTitle(),
                  description: "",
                  imageUrl: RandomData.randomUrl(),
                  price: Random().nextInt(10000).toDouble(),
                ));
              }
            },
            icon: Text("data"),
          ),
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
      body: !dataLoaded
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () {
                Provider.of<Cart>(context, listen: false).fetchCart();
                return Provider.of<ProductsProvider>(context, listen: false)
                    .fetchItems()
                    .then((_) {
                  dataLoaded = true;
                });
              },
              child: ProductData.getItems.isEmpty
                  ? Center(
                      child: Text("There are No items in the Shop"),
                    )
                  : GridView.builder(
                      itemCount: products.length,
                      padding: EdgeInsets.all(8),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
            ),
      drawer: sideDrawer(),
    );
  }
}
