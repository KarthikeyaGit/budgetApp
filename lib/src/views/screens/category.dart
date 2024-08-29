import 'package:flutter/material.dart';
import 'package:penny/src/providers/provider.dart';
import 'package:penny/src/views/screens/home.dart';
import 'package:provider/provider.dart';

class SelectCategory extends StatefulWidget {
  const SelectCategory({super.key});

  @override
  State<SelectCategory> createState() => _SelectCategoryState();
}

class _SelectCategoryState extends State<SelectCategory> {
  // Predefined categories
  final List<String> predefinedCategories = [
    'Salary',
    'Housing',
    'Fuel',
    'Food',
    'Entertainment',
    'Insurance',
    'Healthcare'
  ];

  // All categories (including manually added ones)
  List<String> categories = [
    'Salary',
    'Housing',
    'Fuel',
    'Food',
    'Entertainment',
    'Insurance',
    'Healthcare'
  ];

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    String code = Provider.of<UserDataNotifier>(context, listen: false)
        .userData
        .selectedCurrency;
    print("currency in third page  " + code);
  }

  // Function to add a new category to the list
  void _addCategory() {
    final newCategory = _controller.text.trim();
    if (newCategory.isNotEmpty && !categories.contains(newCategory)) {
      setState(() {
        categories.add(newCategory);
      });
      Provider.of<UserDataNotifier>(context, listen: false)
          .addCategory(newCategory);
      _controller.clear();
    }
  }

  // Function to remove a manually added category
  void _removeCategory(String category) {
    setState(() {
      categories.remove(category);
    });
    Provider.of<UserDataNotifier>(context, listen: false)
        .removeCategory(category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          toolbarHeight: 40,
          automaticallyImplyLeading: false,
          title: const Text(
            'Select Categories',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[900],
                        hintText: 'Enter Category',
                        hintStyle: TextStyle(color: Colors.grey[500]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 54, 54, 54),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(
                          color: Color.fromARGB(255, 125, 125, 125),
                          width: 2.0,
                        ),
                      ),
                    ),
                    onPressed: _addCategory,
                    child: const Text(
                      "Add",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: categories.map((c) => _buildCategoryChip(c)).toList(),
              ),
            ],
          ),
        ),
        floatingActionButton: SizedBox(
          width: 100,
          child: FloatingActionButton(
            onPressed: () {
              // saveName(_nameController.text, '');

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
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
        ));
  }

  Widget _buildCategoryChip(String label) {
    // Check if the category is predefined
    final bool isPredefined = predefinedCategories.contains(label);

    return Chip(
      label: Text(
        label,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.grey[800],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      // Only show the delete icon if the category is not predefined
      deleteIcon: isPredefined ? null : Icon(Icons.close, color: Colors.white),
      onDeleted: isPredefined ? null : () => _removeCategory(label),
    );
  }
}
