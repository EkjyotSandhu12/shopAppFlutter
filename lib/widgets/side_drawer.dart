import 'package:flutter/material.dart';
import 'package:shop_app/pages/order_page.dart';

import '../pages/product_overview_page.dart';

class sideDrawer extends StatelessWidget {
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.6,
      backgroundColor: Theme.of(context).canvasColor,
      child: Column(
        children: [
          AppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            title: Text(
              "Menu",
              style: TextStyle(fontSize: 20),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            automaticallyImplyLeading: false,
          ),
          Divider(
              thickness: 8,
              height: 0,
              color: Theme.of(context).colorScheme.background),
          Container(
            color: Theme.of(context).colorScheme.primary,
            child: ListTile(
              title: Text("Home"),
              leading: Icon(Icons.home),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(ProductOverviewPage.routeName);
              },
            ),
          ),
          Divider(
            height: 1,
          ),
          Container(
            color: Theme.of(context).colorScheme.primary,
            child: ListTile(
              title: Text("Orders"),
              leading: Icon(Icons.shop),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(OrderPage.routeName);
              },
            ),
          )
        ],
      ),
    );
  }
}
