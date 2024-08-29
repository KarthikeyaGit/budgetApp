import 'package:flutter/material.dart';
import 'package:penny/src/models/userData.dart';

class UserDataNotifier extends ChangeNotifier {
  final UserData _userData = UserData();

  UserData get userData => _userData;

  void updateName(String name) {
    _userData.name = name;
    notifyListeners();
  }

  void updateCurrency(String currency) {
    _userData.selectedCurrency = currency;
    notifyListeners();
  }

  void addCategory(String category) {
    _userData.categories.add(category);
    notifyListeners();
  }

   void removeCategory(String category) {
    _userData.categories.remove(category);
    notifyListeners();
  }

}
