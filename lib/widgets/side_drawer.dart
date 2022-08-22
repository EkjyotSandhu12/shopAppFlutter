import 'package:flutter/material.dart';
import 'package:shop_app/pages/order_page.dart';
import 'package:shop_app/pages/user_product_page.dart';
import 'package:provider/provider.dart';

import '../models/auth.dart';
import '../pages/auth_screen.dart';
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
              thickness: 1,
              height: 0,
              color: Theme.of(context).colorScheme.background),
          Container(
            color: Colors.white,
            child: ListTile(
              title: Text("Home", style: TextStyle(color: Colors.black),),
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
            color: Colors.white,
            child: ListTile(
              title: Text("Orders", style: TextStyle(color: Colors.black),),
              leading: Icon(Icons.shop),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(OrderPage.routeName);
              },
            ),
          ),
          Divider(
            height: 1,
          ),
          Container(
            color: Colors.white,
            child: ListTile(
              title: Text("Manage Product", style: TextStyle(color: Colors.black),),
              leading: Icon(Icons.settings),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(UserProductPage.routeName);
              },
            ),
          ),
          Container(
            color: Colors.white,
            child: ListTile(
              title: Text("Log Out", style: TextStyle(color: Colors.black),),
              leading: Icon(Icons.exit_to_app),
              onTap: () {
                Navigator.of(context).pushNamed(AuthScreen.routeName);
                Provider.of<Auth>(context, listen: false).logout();
              },
            ),
          )
        ],
      ),
    );
  }
}
