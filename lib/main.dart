import 'package:budgetapp/pages/home_page.dart';
import 'package:budgetapp/pages/loading_page.dart';
import 'package:budgetapp/pages/login_page.dart';
import 'package:budgetapp/pages/navigation.dart';
import 'package:budgetapp/pages/registrations_page.dart';
import 'package:budgetapp/pages/select_currency_page.dart';
import 'package:budgetapp/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


void main() async{
   await dotenv.load(fileName: ".env");
   WidgetsFlutterBinding.ensureInitialized();
  await StorageService.initialize();
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
        '/main': (context) => const Navigation(),
        '/select_currency': (context) => const SelectCurrency(),
        '/login': (context) => const LoginPage(),
        '/registration': (context) => const RegistrationPage(),
        '/dashboard': (context) => const HomePage(),
      },
    );
  }
}
