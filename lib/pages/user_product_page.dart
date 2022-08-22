import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/widgets/user_product_item.dart';

import '../models/product.dart';
import '../widgets/side_drawer.dart';
import 'AddOrEdit_product_page.dart';

class UserProductPage extends StatefulWidget {
  static String routeName = "/UserProductPage";

  @override
  State<UserProductPage> createState() => _UserProductPageState();
}

class _UserProductPageState extends State<UserProductPage> {
  List<Product> products = [];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Your Products"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AddOrEditProductPage.routeName);
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future:  Provider.of<ProductsProvider>(context).getPersonalProduct(),
          builder: (context, futureSnapshot) {

            if(futureSnapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }else {
              products = futureSnapshot.data as List<Product>;
              return products.isEmpty
                  ? Center(child: Text("...You dont have any products\n add some..."))
                  : ListView.builder(
                itemCount: products.length,
                itemBuilder: (_, index) =>
                    ChangeNotifierProvider.value(
                      value: products[index],
                      child: UserProductItem(),
                    ),
              );
            }


          }
        ),
      ),
      drawer: sideDrawer(),
    );
  }
}
