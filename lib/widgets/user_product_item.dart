import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/pages/edit_product_page.dart';

import '../models/product.dart';

class UserProductItem extends StatelessWidget {
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(product.imageUrl)),
      title: Text(product.title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, EditProductPage.routeName);
            },
            icon: Icon(Icons.edit),
            color: Colors.blueGrey,
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.delete_forever),
              color: Theme.of(context).errorColor),
        ],
      ),
    );
  }
}
