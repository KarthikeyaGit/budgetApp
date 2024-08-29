import 'package:penny/src/views/screens/home.dart';
import 'package:penny/src/views/screens/get_started_.dart';
import 'package:penny/src/views/screens/category.dart';
import 'package:penny/src/views/screens/select_currency.dart';
import 'package:penny/src/views/screens/splash_screen.dart';

class AppRouter {
  static getRoutes() {
    return {
      '/': (context) => const SplashScreen(),
      '/getStarted': (context) => const GetStarted(),
      '/home': (context) => const HomeScreen(),
      '/selectCategory': (context) => const SelectCategory(),
      '/selectCurrency': (context) => const SelectCurrency()

    };
  }
}

