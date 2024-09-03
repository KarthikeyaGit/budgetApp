import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:penny/src/routes/app_router.dart';
import 'package:penny/src/views/screens/get_started_.dart';
import 'package:penny/src/views/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

String logo = 'assets/images/logo.svg';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(const Duration(seconds: 2), () {

         _checkOnboardingComplete();
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => GetStarted()),
      // );
              // _checkOnboardingComplete();

    });
  }


  Future<void> _checkOnboardingComplete() async {
    final prefs = await SharedPreferences.getInstance();
    bool? isComplete = prefs.getBool('isSetupComplete');
    print("iscomplete $isComplete");
    if (isComplete == true) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {

        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => GetStarted()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              logo,
              semanticsLabel: 'Penny Logo',
              height: 70,
            ),
            const SizedBox(height: 10),
            const Text(
              "Penny",
              style: TextStyle(fontSize: 30, color: Color(0xFFFEFEFE)),
            ),
          ],
        ),
      ),
    );
  }
}
