import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/pages/products_detail_page.dart';

import '../providers/products_provider.dart';
import './pages/product_overview_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider(
      create: (_) => ProductsProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Lato",
          colorScheme: const ColorScheme.light(
            primary:  Color.fromRGBO(127, 82, 131, 1),
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
              elevation: 5
          ),
          textTheme: const TextTheme(
            bodyText1: TextStyle(
              fontFamily: "Anton",
              color: Colors.white
            ),
          ),
        ),
        title: "Shop App Material widget",
        home: ProductOverviewPage(),
        routes: {
          ProductDetailsPage.routeName : (_) => ProductDetailsPage(),
        },
      ),
    );
  }
}
