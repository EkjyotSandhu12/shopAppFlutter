import 'package:flutter/material.dart';

class Product with ChangeNotifier{
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite = false;

  void setToggleFavourite(){
    isFavorite = !isFavorite;
    notifyListeners();
  }

  Product copyWith({
    required String id,
    required String title,
    required String description,
    required double price,
    required String imageUrl,
    required bool isFavorite,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }


  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.imageUrl,
      required this.price});
}
