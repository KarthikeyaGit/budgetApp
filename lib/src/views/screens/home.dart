import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:penny/src/providers/provider.dart';
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
          String name = Provider.of<UserDataNotifier>(context, listen: false).userData.name;

      String selectedCurrency = Provider.of<UserDataNotifier>(context, listen: false).userData.selectedCurrency;

      List categories = Provider.of<UserDataNotifier>(context, listen: false).userData.categories;
      print("categories: $name $selectedCurrency $categories ");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF010304),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              logo,
              semanticsLabel: 'Penny Logo',
              height: 70,
            ), 
            const SizedBox(height: 30),
            // Username Input Field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                controller: _usernameController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Enter username',
                  labelStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: const Color(0xFF1C1E1F),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Password Input Field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                controller: _passwordController,
                style: const TextStyle(color: Colors.white),
                obscureText: true, // Hide password input
                decoration: InputDecoration(
                  labelText: 'Enter password',
                  labelStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: const Color(0xFF1C1E1F),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Forgot Password Text
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 30),
                child: TextButton(
                  onPressed: () {
                    // Handle "Forgot Password" logic
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Login Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: ElevatedButton(
                onPressed: () {
                  // Handle login logic
                  String username = _usernameController.text;
                  String password = _passwordController.text;
                  print('Username: $username, Password: $password');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF303234),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16),
                ),
              ),
            ),
          ],
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
