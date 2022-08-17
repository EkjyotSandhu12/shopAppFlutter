import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/http_url.dart';

class Product with ChangeNotifier {
  String id;
  String title;
  String description;
  double price;
  String imageUrl;
  bool isFavorite;

  void setToggleFavourite() async {

    isFavorite = !isFavorite;
    notifyListeners();

   
      await http.patch(Uri.parse(HttpUrl.productUrl + "/$id.json"), body: json.encode({
        'isFavourite' : isFavorite,
      })).then((value) {
        if(value.statusCode >= 400){
          isFavorite = !isFavorite;
          notifyListeners();
        }
      });
    

  }

  Product({
    this.isFavorite = false,
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
  });
}
