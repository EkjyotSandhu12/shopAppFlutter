import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/pages/edit_product_page.dart';
import 'package:shop_app/pages/order_page.dart';
import 'package:shop_app/pages/user_product_page.dart';

import './models/cart.dart';
import './models/order.dart';
import './pages/cart_page.dart';
import './pages/product_overview_page.dart';
import './pages/products_detail_page.dart';
import '../providers/products_provider.dart';

void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Orders(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryTextTheme: const TextTheme(
              headline1: TextStyle(
            fontSize: 14,
            color: Colors.white,
          )),
          fontFamily: "Lato",
          colorScheme: const ColorScheme.light(
            primary: Color.fromRGBO(127, 82, 131, 1),
            secondary: Color.fromRGBO(166, 209, 230, 0.8),
            background: Color.fromRGBO(61, 60, 66, 0.8),
          ),
          canvasColor: const Color.fromRGBO(254, 251, 246, 1),
          appBarTheme: const AppBarTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              elevation: 5),
          textTheme: const TextTheme(
            bodyText1: TextStyle(fontFamily: "Anton", color: Colors.white),
          ),
        ),
        initialRoute: ProductOverviewPage.routeName,
        title: "Shop App Material widget",
        routes: {
          ProductOverviewPage.routeName: (_) => ProductOverviewPage(),
          ProductDetailsPage.routeName: (_) => ProductDetailsPage(),
          CartPage.routeName: (_) => CartPage(),
          OrderPage.routeName: (_) => OrderPage(),
          UserProductPage.routeName: (_) => UserProductPage(),
          EditProductPage.routeName: (_) => EditProductPage(),
        },
      ),
    );
  }
}
