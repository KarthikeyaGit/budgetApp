import 'package:flutter/material.dart';
import 'package:penny/src/models/category.dart';
import 'package:penny/src/providers/user.dart';
import 'package:penny/src/services/database_healper.dart';
import 'package:penny/src/views/screens/home.dart';
import 'package:provider/provider.dart';

class SelectCategory extends StatefulWidget {
  final bool userExists;
  const SelectCategory(
      {super.key, this.userExists = true}); // Constructor updated

  @override
  State<SelectCategory> createState() => _SelectCategoryState();
}

class _SelectCategoryState extends State<SelectCategory> {
  // Predefined categories

  List<Category> categories = [];

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    String code =
        Provider.of<UserNotifier>(context, listen: false).user.currency;
    getCategories();
    print("currency in third page  " + code);
  }

  void getCategories() async {
    List<Map<String, dynamic>> fetchedCategories =
        await DatabaseHelper().getCategories();

    setState(() {
      categories =
          fetchedCategories.map((map) => Category.fromMap(map)).toList();
      print("data $categories");
    });
  }

  void _addCategory() async {
    final newCategory = _controller.text.trim();
    if (newCategory.isNotEmpty &&
        !categories.any((cat) => cat.categoryName == newCategory)) {
      Category inserted = await DatabaseHelper().addCategory(newCategory);
      setState(() {
        categories.add(inserted);
      });

      print("category $categories");
      _controller.clear();
    }
  }

  void _removeCategory(int id) async {
    await DatabaseHelper().removeCategory(id);
    setState(() {
      categories.removeWhere((cat) => cat.categoryId == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          toolbarHeight: 40,
          automaticallyImplyLeading: false,
          title: const Text(
            'Categories',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      style: const TextStyle(color: Colors.white),
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
            ),
            Expanded(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    alignment: WrapAlignment.start,
                    runAlignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children:
                        categories.map((c) => _buildCategoryChip(c)).toList(),
                  ),
                ),
              ),
            )
          ],
        ),
        floatingActionButton: SizedBox(
          width: 100,
          child: FloatingActionButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    // Show the dialog box
                    return DialogBox();
                  });

              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Done",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
                SizedBox(width: 7),
                // Icon(
                //   Icons.arrow_forward_outlined,
                //   size: 22.0,
                // ),
              ],
            ),
          ),
        ));
  }

  Widget DialogBox() {
    return AlertDialog(
      backgroundColor: Colors.black, // Black background
      contentPadding:
          EdgeInsets.zero, // Remove default padding for custom border
      content: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 1), // White border
          borderRadius: BorderRadius.circular(8.0), // Optional: Rounded corners
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: const [
              CircularProgressIndicator(
                color: Colors.white, // White loading indicator
              ),
              SizedBox(width: 20),
              Expanded(
                child: Text(
                  "Setting up the account...",
                  style: TextStyle(color: Colors.white), // White text
                ),
              ),
            ],
          ),
        ),
      ),
      // title: const Text(
      //   "Setup",
      //   style: TextStyle(color: Colors.white), // White text for the title
      // ),
    );
  }

  Widget _buildCategoryChip(Category c) {
    return Chip(
      label: Text(
        c.categoryName,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.grey[800],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      // Show delete icon only if the category is not a default category (defaultType = 0)
      deleteIcon:
          c.defaultType == 0 ? Icon(Icons.close, color: Colors.white) : null,
      onDeleted:
          c.defaultType == 0 ? () => _removeCategory(c.categoryId) : null,
    );
  }
}
