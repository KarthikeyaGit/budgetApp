import 'package:budgetapp/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

String logo = 'assets/images/logo.svg';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
        Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor:  Color(0xFF010304),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             SvgPicture.asset(
              logo,
              semanticsLabel: 'Penny Logo',
            ),
            const SizedBox(height: 20),
            const Text(
          "Penny",
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 255, 255, 255)),
        ),
          ],
        )
      ),
    );
  }
}
