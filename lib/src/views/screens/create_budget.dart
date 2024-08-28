import 'package:flutter/material.dart';

class CreateBudget extends StatefulWidget {
  const CreateBudget({super.key});

  @override
  State<CreateBudget> createState() => _CreateBudgetState();
}

class _CreateBudgetState extends State<CreateBudget> {
  @override
  Widget build(BuildContext context) {
    return _buildPage4();
  }
}

Widget _buildPage4() {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Create a budget per month',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
        ),
        body: Container(
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[900],
                    hintText: 'Enter Budget',
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }