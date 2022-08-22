import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/auth.dart';
import '../models/customException.dart';
import '../models/product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [
    /*
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter ',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),*/
  ];

  Auth authObject;

  ProductsProvider(this.authObject);

  String getImage(String id) {
    return _items.firstWhere((element) => element.id == id).imageUrl;
  }

  List<Product> get getItems {

    return [..._items];
  }

  Future<List<Product>> getPersonalProduct() async {

    List<Product> fetchedList = [];

    final url = 'https://flutter-shop-app-4f901-default-rtdb.firebaseio.com/product.json?auth=${authObject.tokenKey}&orderBy="userId"&equalTo="${authObject.userId}"';

    final response = await http.get(Uri.parse(url));
    final resposeData = json.decode(response.body) as Map;

    _items.forEach((element) {
      if(resposeData.containsKey(element.id)) {
        fetchedList.add(element);
      }
    });

    return fetchedList;
  }

  Future<void> fetchItems() async {
    List<Product> fetchedList = [];
    try {
       var url =
          "https://flutter-shop-app-4f901-default-rtdb.firebaseio.com/product.json?auth=${authObject.tokenKey}";
      final response = await http.get(Uri.parse(url));

      final responseData = json.decode(response.body) == null ? {} : json.decode(response.body) as Map<String, dynamic>;

      url = "https://flutter-shop-app-4f901-default-rtdb.firebaseio.com/${authObject.userId}/userFav.json?auth=${authObject.tokenKey}";
      final userResponse = await http.get(Uri.parse(url));
      final userResponseData = json.decode(userResponse.body) == null ? {} : json.decode(userResponse.body) as Map<String, dynamic>;

      responseData.forEach((key, value) {
        fetchedList.add(Product(
          id: key,
          title: value['title'],
          description: value['description'],
          imageUrl: value['image'],
          price: value['price'],
          isFavorite: userResponseData[key] == null ? false : userResponseData[key]['isFavourite'],
        ));
      });
    }catch(e){
      print(e.toString());
    } finally {
      notifyListeners();
      _items = fetchedList;
    }
  }

  Future<void> addProduct(Product item) async {
    final url =
        "https://flutter-shop-app-4f901-default-rtdb.firebaseio.com/product.json?auth=${authObject.tokenKey}";
    await http
        .post(
      Uri.parse(url),
      body: json.encode({
        'userId' : authObject.userId,
        'title': item.title,
        'description': item.description,
        'image': item.imageUrl,
        'price': item.price,
      }),
    )
        .then((value) {
          print(json.decode(value.body)['name']);
      item.id = json.decode(value.body)['name'];
      _items.add(item);
      notifyListeners();
    });
  }

  Future<void> updateProduct(Product item) async {
    final url =
        "https://flutter-shop-app-4f901-default-rtdb.firebaseio.com/product/${item.id}.json?auth=${authObject.tokenKey}";
    http.patch(Uri.parse(url),
        body: json.encode({
          'title': item.title,
          'description': item.description,
          'image': item.imageUrl,
          'price': item.price,
        }));
    notifyListeners();
  }

  bool contains(Product p) {
    return _items.contains(p);
  }

  Future<void> deleteProduct(Product item) {
    final url =
        "https://flutter-shop-app-4f901-default-rtdb.firebaseio.com/product/${item.id}.json?auth=${authObject.tokenKey}";

    return http.delete(Uri.parse(url)).then((response) {
      if (response.statusCode >= 400) {
        throw customException("Deleting Failed");
      } else {
        fetchItems();
      }
    });
  }
}
