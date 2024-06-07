import 'package:budgetapp/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final base_Url = dotenv.env['BASE_URL'];

  Future<void> _signUp() async {
    print('login click');

    final String username = _usernameController.text;
    final String email = _emailController.text;
    final String password = _passwordController.text;

    // Your API endpoint for login
    final String apiUrl = '$base_Url/api/signup';
    print('login data: $username $password $apiUrl');

    try {
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode({'username': username, 'email': username, 'password': password}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Parse response body
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData['hasError'] == false) {
          Fluttertoast.showToast(
            msg: "Login successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );

          print("login api ${responseData['user']['account_balance']}");
          StorageService.saveData('user', jsonEncode(responseData['user']));
          // print("shared ${StorageService.getData('user')}");
          if (response.statusCode == 200) {
            Navigator.pushReplacementNamed(context, '/login');
          }
          
        } else {
          print('Login failed: ${responseData['message']}');

          Fluttertoast.showToast(
            msg: "Login failed: ${responseData['message']}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
          // Login failed
        }
      } else {
        // Handle other status codes
        print('Login failed. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Exception occurred during login
      print('Error occurred during login: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome Back!'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username/Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username or email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Add functionality for forgot password
                  },
                  child: Text('Forgot Password?'),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    print("click login---");
                    // _login();
                  }
                },
                child: Text('Login'),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    // Navigate to create account page
                  },
                  child: Text('Create Account'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
