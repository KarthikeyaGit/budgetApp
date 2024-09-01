import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:penny/src/models/user.dart';
import 'package:penny/src/providers/user.dart';
import 'package:penny/src/views/screens/category.dart';
import 'package:provider/provider.dart';
import '../../models/currency.dart';

class SelectCurrency extends StatefulWidget {
  const SelectCurrency({super.key});

  @override
  State<SelectCurrency> createState() => _SelectCurrencyState();
}

class _SelectCurrencyState extends State<SelectCurrency> {
  List<Currency> _currencies = [];
  List<Currency> _filteredCurrencies = [];
  String? selectedCurrencyCode;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadCurrencyData();
  String username = Provider.of<UserNotifier>(context, listen: false).user.name;
  print("username in secound page  "+username); 
   }

  Future<void> _loadCurrencyData() async {
    final String response =
        await rootBundle.loadString('assets/data/currency.json');
    final Map<String, dynamic> data = json.decode(response);

    setState(() {
      _currencies =
          data.entries.map((entry) => Currency.fromJson(entry.value)).toList();
      _filteredCurrencies =
          List.from(_currencies); // Initialize with all currencies
    });
  }

  void _filterCurrencies(String query) {
    setState(() {
      searchQuery = query;
      _filteredCurrencies = _currencies.where((currency) {
        return currency.name.toLowerCase().contains(query.toLowerCase()) ||
            currency.code.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildPage2();
  }

  Widget _buildPage2() {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        automaticallyImplyLeading: false,
        title: const Text(
          'Select Currency',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: bodybuilder(),
      floatingActionButton: selectedCurrencyCode?.isNotEmpty == true
          ? SizedBox(
              width: 100,
              child: FloatingActionButton(
                onPressed: () {
                  // saveName(_nameController.text, '');

                    Provider.of<UserNotifier>(context, listen: false)
                  .updateCurrency(selectedCurrencyCode!);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SelectCategory()));
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Next",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(width: 7),
                    Icon(
                      Icons.arrow_forward_outlined,
                      size: 22.0,
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }

  Widget bodybuilder() {
    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search bar
            TextField(
              decoration: const InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(color: Color(0xFFD7D7D7)),
                prefixIcon: Icon(Icons.search, color: Color(0xFFD7D7D7)),
                filled: false,
                fillColor: Color.fromARGB(255, 27, 27, 27),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(color: Colors.white), // Add this line
              onChanged:
                  _filterCurrencies, // Call filter function on input change
            ),
            const SizedBox(height: 20),

            // Display selected currency
            if (selectedCurrencyCode != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  'Selected Currency: $selectedCurrencyCode',
                  style: const TextStyle(color: Colors.white),
                ),
              ),

            // List of currencies
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 2.0,
                ),
                itemCount: _filteredCurrencies.length,
                itemBuilder: (context, index) {
                  final currency = _filteredCurrencies[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCurrencyCode =
                            currency.code; 
                  //                Provider.of<UserDataNotifier>(context, listen: false)
                  // .updateName(currency.code);

                      });
                    },
                    child: Card(
                      color: selectedCurrencyCode == currency.code
                          ? Colors.blue
                          : Colors.grey[800], // Change color based on selection
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currency.symbol,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              currency.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              currency.code,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
