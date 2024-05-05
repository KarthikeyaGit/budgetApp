import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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

      if (response.statusCode == 200) {
        // Parse response body
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        currencyList = responseData['currencies'];
        // print("currencies ${responseData['currencies']}");

        // if (responseData['hasError'] == false) {
        // } else {
        //   print('Login failed: ${responseData['message']}');

        //   // Login failed
        // }
      } else {
        // Handle other status codes
        print('Login failed. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Exception occurred during login
      print('Error occurred during login: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Currency"),
        ),
        body: Container(),
      ),
    );
  }
}
