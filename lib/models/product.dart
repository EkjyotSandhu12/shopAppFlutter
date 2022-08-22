import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  String id;
  String title;
  String description;
  double price;
  String imageUrl;
  bool isFavorite;

  void setToggleFavourite(String userId, String authTokenKey) async {
    isFavorite = !isFavorite;
    notifyListeners();

    await http
        .patch(
            Uri.parse(
                "https://flutter-shop-app-4f901-default-rtdb.firebaseio.com/$userId/userFav/$id.json?auth=$authTokenKey"),
            body: json.encode({
              'isFavourite': isFavorite,
            }))
        .then((value) {
      if (value.statusCode >= 400) {
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
