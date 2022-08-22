import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/models/customException.dart';

import '../pages/auth_screen.dart';

class Auth with ChangeNotifier {
  String _token = "";
  DateTime _expiryDate = DateTime.now();
  String _userId = "";
  late Timer autoLogOutTimer;

  bool isAuth() {
    if (_token.isNotEmpty &&
        _userId.isNotEmpty &&
        _expiryDate.isAfter(DateTime.now())) {
      return true;
    } else {
      return false;
    }
  }

  String get tokenKey {
    return _token;
  }

  String get userId {
    return _userId;
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:${urlSegment}?key=AIzaSyC_RC_zdhBHRRHr6HrVYURB8ZglXMFe7Bs';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body) as Map;

      if ((responseData.containsKey('error'))) {
        throw customException(responseData['error']['message']);
      }

      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));

      SharedPreferences sp = await SharedPreferences.getInstance();

      sp.setString(
          'key',
          json.encode({
            'token': responseData['idToken'],
            'userId': responseData['localId'],
            'expiryDate': _expiryDate.toIso8601String(),
          }));

      autoLogOutTimer = Timer(
          Duration(seconds: _expiryDate.difference(DateTime.now()).inSeconds),
          logout);

      notifyListeners();
    } on Exception catch (e) {
      throw e;
    }
  }

  Future<bool> tryAutoLogin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    final body = json.decode((sp.getString('key')!));

    if (body == null || body.isEmpty) {
      return false;
    }
    Map bodyData = body as Map;


    if (DateTime.now().isBefore(DateTime.parse(bodyData['expiryDate']))) {
      _token = bodyData['token'];
      _userId = bodyData['userId'];
      _expiryDate = DateTime.parse(bodyData['expiryDate']);

      autoLogOutTimer = Timer(
          Duration(seconds: _expiryDate.difference(DateTime.now()).inSeconds),
          logout);

      return true;
    }

    return false;
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, "signUp");
  }

  Future<void> signIn(String email, String password) async {
    return _authenticate(email, password, "signInWithPassword");
  }

  Future<void> logout() async {

    _token = "";
    _expiryDate = DateTime.now();
    _userId = "";
    if (autoLogOutTimer != null) {
      autoLogOutTimer.cancel();
    }
    notifyListeners();
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
  }
}
