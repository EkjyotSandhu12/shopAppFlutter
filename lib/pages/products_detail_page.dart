import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';

class ProductDetailsPage extends StatelessWidget {
  static const routeName = "/ProductDetailsPage";

  Widget setPadding(Widget child) {
    return Padding(padding: const EdgeInsets.all(10.0), child: child);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    String productId = ModalRoute.of(context)?.settings.arguments as String;
    final product = Provider.of<ProductsProvider>(context)
        .getItems
        .firstWhere((element) => productId == element.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 30,
          margin: EdgeInsets.all(screenHeight * 0.02),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  height: screenHeight * 0.65,
                  width: double.infinity,
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.fitWidth,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return const Text("messy Url");
                    },
                  ),
                ),
              ),
              setPadding(
                Text(
                  " Price: ${product.price}",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              setPadding(
                Text(
                  "${product.description}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
