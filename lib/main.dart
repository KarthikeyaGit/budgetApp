import 'package:flutter/material.dart';
import 'package:penny/src/providers/category.dart';
import 'package:penny/src/providers/user.dart';
import 'package:penny/src/routes/app_router.dart';
import 'package:penny/src/services/database_healper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper().database; 
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserNotifier()),
        ChangeNotifierProvider(create: (_) => CategoryNotifier()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

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
    if (isLoading) {
      // Show a loading spinner while waiting for setup check
      return Center(child: CircularProgressIndicator());
    }

    return MaterialApp(
      initialRoute: isSetupComplete == true ? '/home' : '/',
      routes: AppRouter.getRoutes(),
      // You can also add a home widget here if necessary
      // home: isSetupComplete == null ? YourCategorySelectPage() : Container(),
    );
  }
}
