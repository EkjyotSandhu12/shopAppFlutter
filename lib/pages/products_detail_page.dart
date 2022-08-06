import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';

class ProductDetailsPage extends StatelessWidget {
  static const routeName = "/ProductDetailsPage";

  @override
  Widget build(BuildContext context) {

    String productId = ModalRoute.of(context)?.settings.arguments as String;
    final product = Provider.of<ProductsProvider>(context)
        .getItems
        .firstWhere((element) => productId == element.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
    );
  }
}
