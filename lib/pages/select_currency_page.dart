// ignore_for_file: use_build_context_synchronously

import 'package:budgetapp/components/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:budgetapp/services/storage_service.dart';

class SelectCurrency extends StatefulWidget {
  const SelectCurrency({super.key});

  @override
  State<SelectCurrency> createState() => _SelectCurrencyState();
}

class _SelectCurrencyState extends State<SelectCurrency> {
  final base_Url = dotenv.env['BASE_URL'];
  var user = jsonDecode(StorageService.getData('user'));
  var currencyList;
  var loading = true;
  var _selectedItem;

  @override
  void initState() {
    super.initState();
    // Call getCurrency function when the widget is initialized
    getCurrency();
  }

  Future<void> getCurrency() async {
    final String apiUrl = '$base_Url/api/currenciesList';

    try {
      final http.Response response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json', 'token': user['token']},
      );
      // print("response ${response.statusCode} ${response.body}");
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body)['currencies'];
        setState(() {
          currencyList = (responseData as List)
              .map<String>((currency) => currency['name'].toString())
              .toList();
          loading = false;
        });
      } else {
        print('Login failed. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred during login: $e');
    }
  }

  Future<void> updateCurrencyByUid(String uid, String currency) async {
    final String apiUrl = '$base_Url/api/updateUserDetailsByUid';

    try {
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json', 'token': user['token']},
        body: jsonEncode({'uid': uid, 'currency': currency}),
      );

      if (response.statusCode == 200) {
        // Handle successful response
        print('Currency updated successfully.');
        Navigator.pushReplacementNamed(context, '/main');
        Fluttertoast.showToast(
          msg: "Currency updated successfully.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Failed to update currency",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        // Handle unsuccessful response
        print('Failed to update currency. Status code: ${response.statusCode}');
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error occurred during currency update",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      // Handle exceptions
      print('Error occurred during currency update: $e');
    }
  }

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.black87,
    backgroundColor: Colors.grey[300],
    minimumSize: const Size(88, 36),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    print("user: ${user['_id']}");

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Currency"),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 3),
                child: Text(
                  "Select Currency",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              loading
                  ? const CircularProgressIndicator()
                  : Dropdown(
                      options: currencyList,
                      selectedValue: _selectedItem,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedItem = newValue;
                        });
                      },
                    ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Account Balance',
                ),
                keyboardType: TextInputType.number,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter account balance';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Budget for month',
                ),
                keyboardType: TextInputType.number,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter account balance';
                  }
                  return null;
                },
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    style: raisedButtonStyle,
                    onPressed: _selectedItem != null
                        ? () {
                            updateCurrencyByUid(user['_id'], _selectedItem);
                          }
                        : null,
                    child: const Text('Next'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
