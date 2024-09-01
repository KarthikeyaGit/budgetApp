import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:penny/src/models/category.dart' as custom_category; // Use an alias

class CategoryNotifier extends ChangeNotifier {
  // Use the alias to reference your custom Category model
  List<custom_category.Category> _categories = [];

  List<custom_category.Category> get categories => _categories;

  void addCategory(custom_category.Category category) {
    _categories.add(category);
    notifyListeners();
  }


  void removeCategory(int index) {
    if (index >= 0 && index < _categories.length) {
      _categories.removeAt(index);
      notifyListeners();
    }
  }

  //   void updateCategory(int index, custom_category.Category category) {
  //   if (index >= 0 && index < _categories.length) {
  //     _categories[index] = category;
  //     notifyListeners();
  //   }
  // }

  // void clearCategories() {
  //   _categories.clear();
  //   notifyListeners();
  // }

  // void setCategories(List<custom_category.Category> categories) {
  //   _categories = categories;
  //   notifyListeners();
  // }
}
