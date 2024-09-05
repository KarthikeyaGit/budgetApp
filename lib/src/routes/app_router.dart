import 'package:flutter/material.dart';
import 'package:penny/src/views/screens/accounts.dart';
import 'package:penny/src/views/screens/add_accounts.dart';
import 'package:penny/src/views/screens/home.dart';
import 'package:penny/src/views/screens/get_started_.dart';
import 'package:penny/src/views/screens/category.dart';
import 'package:penny/src/views/screens/select_currency.dart';
import 'package:penny/src/views/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppRouter {
  static getRoutes() {
    return {
      // '/': (context) => const SplashScreen(),
      '/getStarted': (context) => const GetStarted(),
      '/selectCurrency': (context) => const SelectCurrency(),
      '/accounts': (context) => const Accounts(),
      'addAccounts': (context) => const AddAccounts(),
      '/selectCategory': (context) => const SelectCategory(),
      '/home': (context) => const HomeScreen(),
    };
  }

  
}
