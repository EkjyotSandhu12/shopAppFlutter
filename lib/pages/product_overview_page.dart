import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';

import '../models/product.dart';
import '../widgets/product_item.dart';

class ProductOverviewPage extends StatelessWidget {
  Widget build(BuildContext context) {
    final ProductData = Provider.of<ProductsProvider>(context);
    final products = ProductData.getItems;
    return Scaffold(
      appBar: AppBar(
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
        itemBuilder: (_, index) => ChangeNotifierProvider(
          create: (_) => products[index],
          child: ProductItem(),
        ),
      ),
    );
  }
}
