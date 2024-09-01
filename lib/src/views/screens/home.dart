import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:penny/src/providers/category.dart';
import 'package:penny/src/providers/user.dart';
import 'package:provider/provider.dart';

String logo = 'assets/images/logo.svg';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Define controllers to capture input from TextFields
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
          String name = Provider.of<UserNotifier>(context, listen: false).user.name;

      String selectedCurrency = Provider.of<UserNotifier>(context, listen: false).user.currency;

      List categories = Provider.of<CategoryNotifier>(context, listen: false).categories;
      print("categories: $name $selectedCurrency $categories ");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF010304),
      body: Center(),
    );
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
