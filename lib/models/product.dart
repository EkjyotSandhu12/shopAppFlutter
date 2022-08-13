import 'package:flutter/material.dart';

class Product with ChangeNotifier{
   String id;
   String title;
   String description;
   double price;
   String imageUrl;
   bool isFavorite = false;

  void setToggleFavourite(){
    isFavorite = !isFavorite;
    notifyListeners();
  }



  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.imageUrl,
      required this.price});
}
