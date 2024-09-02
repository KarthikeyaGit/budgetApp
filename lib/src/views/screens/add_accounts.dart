import 'package:flutter/material.dart';
import 'package:penny/src/models/accounts.dart';
import 'package:penny/src/services/database_healper.dart';

class AddAccounts extends StatefulWidget {
  const AddAccounts({super.key});

  @override
  State<AddAccounts> createState() => _AddAccountsState();
}

class _AddAccountsState extends State<AddAccounts> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  int _balance = 0;
  int _used = 0;
  String? _selectedAccountType;
  bool _isAccountTypeSelected = true; // To track if an account type is selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 40,
        automaticallyImplyLeading: false,
        title: const Text(
          "Add Account",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Account type chips
              Wrap(
                spacing: 8.0, // Horizontal space between chips
                runSpacing: 4.0, // Vertical space between rows of chips
                children: [
                  ChoiceChip(
                    label: Text('Cash'),
                    selected: _selectedAccountType == 'Cash',
                    onSelected: (selected) {
                      setState(() {
                        _selectedAccountType = 'Cash';
                        _isAccountTypeSelected = true; // Reset the error state
                      });
                    },
                    selectedColor: Colors.teal,
                    backgroundColor: Colors.grey[700],
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  ChoiceChip(
                    label: Text('Credit Card'),
                    selected: _selectedAccountType == 'Credit Card',
                    onSelected: (selected) {
                      setState(() {
                        _selectedAccountType = 'Credit Card';
                        _isAccountTypeSelected = true;
                      });
                    },
                    selectedColor: Colors.teal,
                    backgroundColor: Colors.grey[700],
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  ChoiceChip(
                    label: Text('Debit Card'),
                    selected: _selectedAccountType == 'Debit Card',
                    onSelected: (selected) {
                      setState(() {
                        _selectedAccountType = 'Debit Card';
                        _isAccountTypeSelected = true;
                      });
                    },
                    selectedColor: Colors.teal,
                    backgroundColor: Colors.grey[700],
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              if (!_isAccountTypeSelected) // Show error message if not selected
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Please select an account type',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Account Name',
                  labelStyle:
                      TextStyle(color: Color.fromARGB(255, 198, 198, 198)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF4C4C4C)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFEFEFE)),
                  ),
                ),
                style: const TextStyle(color: Color(0xFFFEFEFE)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the account name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Balance',
                  labelStyle:
                      TextStyle(color: Color.fromARGB(255, 198, 198, 198)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF4C4C4C)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFEFEFE)),
                  ),
                ),
                style: const TextStyle(color: Color(0xFFFEFEFE)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the balance';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _balance = int.parse(value!);
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Used',
                  labelStyle:
                      TextStyle(color: Color.fromARGB(255, 198, 198, 198)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF4C4C4C)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFEFEFE)),
                  ),
                ),
                style: const TextStyle(color: Color(0xFFFEFEFE)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the used amount';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _used = int.parse(value!);
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (_selectedAccountType == null) {
                      setState(() {
                        _isAccountTypeSelected = false; // Show the error state
                      });
                      return; // Do not proceed if account type is not selected
                    }

                    print("valid");
                    _formKey.currentState!.save();

                    // Create an Account object with the form data
                    Account newAccount = Account(
                      userId:
                          1, // Assuming user ID is 1 for now, you can change it dynamically
                      accountName: _name,
                      accountType: _selectedAccountType!,
                      balance: _balance.toDouble(),
                      used: _used,
                    );

                    // Insert the new account into the database
                    await DatabaseHelper().insertAccount(newAccount);

                    // Optionally, show a confirmation message or navigate back
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Account added successfully')),
                    );

                    Navigator.pop(
                        context); // Navigate back to the previous screen
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
