import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:penny/src/models/category.dart';
import 'package:penny/src/services/database_healper.dart';
import 'package:penny/src/models/accounts.dart';
import 'package:penny/src/views/screens/add_accounts.dart';
import 'package:penny/src/views/screens/category.dart';

String iconCard = 'assets/images/icon_card.svg';

class Accounts extends StatefulWidget {
  const Accounts({super.key});

  @override
  State<Accounts> createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  List<Account> _accounts = [];

  @override
  void initState() {
    super.initState();
    _fetchAccounts();
  }

  Future<void> _fetchAccounts() async {
    List<Map<String, dynamic>> fetchAccounts =
        await DatabaseHelper().getAccounts();
    setState(() {
      _accounts = fetchAccounts.map((map) => Account.fromMap(map)).toList();
    });
  }

  // _deleteAccount(accountId) async {
  //   int id = await DatabaseHelper().deleteAccount(accountId);

  //   if (id != null) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Account added successfully')),
  //     );
  //     _fetchAccounts();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Accounts",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddAccounts())).then((_) {
                  // Call _fetchAccounts when returning to this page
                  _fetchAccounts();
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFF151515), // Light black background
                side: const BorderSide(
                  color: Colors.white, // White border
                  width: 0.5, // Border width
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text(
                "Add",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: _accounts.isEmpty
          ? const Center(
              child: Text(
              "No Accounts",
              style: TextStyle(color: Colors.white),
            )

              //  CircularProgressIndicator(
              //   color: Colors.teal,
              // ),
              )
          : ListView.builder(
              itemCount: _accounts.length,
              itemBuilder: (context, index) {
                Account account = _accounts[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: accountCardItem(account),
                );
              },
            ),
      floatingActionButton: SizedBox(
          width: 100,
          child:FloatingActionButton(
                onPressed: () {
                  //  Provider.of<UserNotifier>(context, listen: false)
                  // .updateName(_nameController.text);
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
    );
  }

  Widget accountCardItem(account) {
    //TODO: add the ability to edit account
    return Card(
      color: const Color(0xFF151718),
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Color(0xFF323435), width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: SvgPicture.asset(
                        iconCard,
                        semanticsLabel: 'Penny Logo',
                        height: 26,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          account.accountType,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                        Text(
                          account.accountName,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ],
                ),

                //TODO: add a delete warning
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    // Implement delete functionality
                    await DatabaseHelper().deleteAccount(account.accountId!);
                    _fetchAccounts(); // Refresh the list after deletion
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget accountCard(account) {
    return Card(
      color: const Color(0xFF151718),
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Color(0xFF323435), width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: SvgPicture.asset(
                        iconCard,
                        semanticsLabel: 'Penny Logo',
                        height: 26,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          account.accountType,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                        Text(
                          account.accountName,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ],
                ),

                //TODO: add a delete warning
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    // Implement delete functionality
                    await DatabaseHelper().deleteAccount(account.accountId!);
                    _fetchAccounts(); // Refresh the list after deletion
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Total Balance",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "₹ ${account.balance.toStringAsFixed(2)}",
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Used",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "₹ ${account.used.toString()}",
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
