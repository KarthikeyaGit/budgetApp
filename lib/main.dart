import 'package:flutter/material.dart';
import 'package:penny/src/providers/category.dart';
import 'package:penny/src/providers/user.dart';
import 'package:penny/src/routes/app_router.dart';
import 'package:penny/src/services/database_healper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveLoginStatus(bool isLoggedIn) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', isLoggedIn);
}

Future<bool> getLoginStatus() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isLoggedIn') ?? false;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper().database; 
  final isLoggedIn = await getLoginStatus();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserNotifier()),
        ChangeNotifierProvider(create: (_) => CategoryNotifier()),
      ],
      child: MyApp(isLoggedIn: isLoggedIn),
    ),
  );
}

class MyApp extends StatefulWidget {
  final bool isLoggedIn;

  const MyApp({required this.isLoggedIn, super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? isSetupComplete;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkSetupComplete();
  }

  Future<void> _checkSetupComplete() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isSetupComplete = prefs.getBool('isSetupComplete');
      isLoading = false; // Set loading to false after fetching the value
    });
  }

  @override
  Widget build(BuildContext context) {
    // if (isLoading) {
    //   // Show a loading spinner while waiting for setup check
    //   return const MaterialApp(
    //     home: Center(child: CircularProgressIndicator()),
    //   );
    // }

    // If setup is not complete, navigate to the setup page
    // if (isSetupComplete == null || !isSetupComplete!) {
    //   return const MaterialApp(
    //     home: YourCategorySelectPage(), // Replace with your setup page
    //   );
    // }

    return MaterialApp(
      initialRoute: widget.isLoggedIn ? '/home' : '/getStarted',
      routes: AppRouter.getRoutes(),
    );
  }
}
