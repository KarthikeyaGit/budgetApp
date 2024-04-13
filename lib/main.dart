import 'package:budgetapp/pages/home_page.dart';
import 'package:budgetapp/pages/loading_page.dart';
import 'package:budgetapp/pages/login_page.dart';
import 'package:budgetapp/pages/registrations_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
routes: {
     '/': (context) => const LoadingPage(),
    '/login': (context) => const LoginPage(),
    '/registration': (context) => const RegistrationPage(),
    '/home': (context) => const HomePage(),
  },    );
  }
}

