import 'dart:ui';

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

    String selectedCurrency =
        Provider.of<UserNotifier>(context, listen: false).user.currency;

    List categories =
        Provider.of<CategoryNotifier>(context, listen: false).categories;
    print("categories: $name $selectedCurrency $categories ");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF010304),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Home",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text('Welcome John!',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                color: const Color(0xFF151718),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Color(0xFF323435), width: 1.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Total Balance',
                          style: TextStyle(color: Colors.white)),
                      Text('₹ 125000.00',
                          style: TextStyle(color: Colors.white, fontSize: 24)),
                      SizedBox(
                        height: 7,
                      ),
                      Divider(
                        color: Color(0xFF323435), // Color of the line
                        thickness: 2, // Thickness of the line
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Budget',
                                  style: TextStyle(color: Colors.white)),
                              SizedBox(
                                height: 2,
                              ),
                              Text('₹ 87500.00',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Used',
                                  style: TextStyle(color: Colors.white)),
                              SizedBox(
                                height: 2,
                              ),
                              Text('₹ 125000.00',
                                  style: TextStyle(
                                      color: Color(0xFFFEFEFE), fontSize: 18)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      LinearProgressIndicator(
                        minHeight: 7,
                        borderRadius: BorderRadius.circular(10),
                        value: 0.65, // 20% filled
                        semanticsLabel: 'Linear progress indicator',
                        backgroundColor: Colors.grey[
                            300], // Background color of the unfilled portion
                        valueColor: AlwaysStoppedAnimation<Color>(const Color(
                            0xFF379B9B)), // Color of the filled portion
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(" Transactions",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17)),
                  Text("Show all  ",
                      style: TextStyle(
                          color: const Color(0xFFCACACA),
                          fontWeight: FontWeight.bold,
                          fontSize: 17))
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  
                ],
              )
            ],
          ),
        ),
      ),
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
