import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:penny/src/views/screens/select_currency.dart';
import 'package:penny/src/shared/shared.dart';

String logo = 'assets/images/logo.svg';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  final preferencesService = Shared();
  final TextEditingController _nameController = TextEditingController();
  bool _showButton = false;


  @override
  void initState() {
    super.initState();
        _nameController.addListener(_checkNameLength);
         _loadUsername();

   
  }

    void _checkNameLength() {
      if(_nameController.text.length > 2){
        preferencesService.save('username', _nameController.text);
      }
    setState(() {
      _showButton = _nameController.text.length > 3;
    });
  }

  Future<void> _loadUsername() async {
    // Fetch the username using PreferencesService
    String? uname= await preferencesService.get('username');
    print("uname $uname");
    setState(() {
      _nameController.text = uname ?? ''; // Assign the username to the controller
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF010304),
      body: _buildPage1(),
      floatingActionButton: _showButton ? SizedBox(
        width: 100,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SelectCurrency()));
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Next",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              SizedBox(width: 7),
              Icon(
                Icons.arrow_forward_outlined,
                size: 22.0,
              ),
            ],
          ),
        ),
      ): null,
    );
  }

  Widget _buildPage1() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 70),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                logo,
                semanticsLabel: 'Penny Logo',
                height: 80,
              ),
            ],
          ),
          const SizedBox(height: 40),
          const Text(
            "Welcome to Penny!",
            style: TextStyle(fontSize: 24, color: Color(0xFFFEFEFE)),
          ),
          const SizedBox(height: 10),
          const Text(
            "Easily track your expenses and manage your budget with Penny. Get started on your journey to better financial health today!",
            style: TextStyle(fontSize: 16, color: Color(0xFFFEFEFE)),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Enter your name',
              labelStyle: TextStyle(color: Color.fromARGB(255, 198, 198, 198)),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF4C4C4C)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFFEFEFE)),
              ),
            ),
            style: const TextStyle(color: Color(0xFFFEFEFE)),
          ),
        ],
      ),
    );
  }
}
