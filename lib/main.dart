import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;
import 'package:shop_app/pages/AddOrEdit_product_page.dart';
import 'package:shop_app/pages/auth_screen.dart';
import 'package:shop_app/pages/order_page.dart';
import 'package:shop_app/pages/user_product_page.dart';

import './models/cart.dart';
import './models/order.dart';
import './pages/cart_page.dart';
import './pages/product_overview_page.dart';
import './pages/products_detail_page.dart';
import '../providers/products_provider.dart';
import 'models/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Auth auth = Auth();

  Widget build(BuildContext context) {
    return provider.MultiProvider(
      providers: [
        provider.ChangeNotifierProvider.value(
          value: auth,
        ),
        provider.ChangeNotifierProvider(
          create: (_) => ProductsProvider(auth),
        ),
        provider.ChangeNotifierProvider(
          create: (_) => Orders(auth),
        ),
        provider.ChangeNotifierProvider(
          create: (_) => Cart(auth),
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
        home: auth.isAuth()
            ? ProductOverviewPage()
            : FutureBuilder(
                future: auth.tryAutoLogin(),
                builder: (context, futureData) {
                  if (futureData.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Text("loading"),
                    );
                  } else if (futureData.hasError) {
                    print(futureData.error.toString());
                    return AuthScreen();
                  } else {
                    return  futureData.data == true
                        ? ProductOverviewPage()
                        : AuthScreen();
                  }
                },
              ),
        title: "Shop App Material widget",
        routes: {
          AuthScreen.routeName: (_) => AuthScreen(),
          ProductOverviewPage.routeName: (_) => ProductOverviewPage(),
          ProductDetailsPage.routeName: (_) => ProductDetailsPage(),
          CartPage.routeName: (_) => CartPage(),
          OrderPage.routeName: (_) => OrderPage(),
          UserProductPage.routeName: (_) => UserProductPage(),
          AddOrEditProductPage.routeName: (_) => AddOrEditProductPage(),
        },
      ),
    );
  }
}
