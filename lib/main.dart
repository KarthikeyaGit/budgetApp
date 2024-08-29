import 'package:flutter/material.dart';
import 'package:penny/src/routes/app_router.dart';
import 'package:penny/src/services/database_healper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();


  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late DatabaseHelper dbHelper;
 @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper();
    _initializeDatabase();
  }

  void _initializeDatabase() async {
    await dbHelper.database; // This triggers the database initialization
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: AppRouter.getRoutes(), // Use the routing logic from AppRouter
    );
  }
}
