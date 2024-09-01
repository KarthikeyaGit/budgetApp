import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:penny/src/models/user.dart';

class UserNotifier extends ChangeNotifier {
  final User _user = User(name: '', currency: '');

  User get user => _user;

  void updateName(String name) {
    _user.name = name;
    notifyListeners();
  }

  void updateCurrency(String currency) {
    _user.currency = currency;
    notifyListeners();
  }

}
