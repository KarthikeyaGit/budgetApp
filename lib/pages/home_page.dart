import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    int usedBudget = 800; // Example initial value
    int totalBudget = 1000; // Example total budget

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 10, right: 15, bottom: 0, left: 15),
            child: Text(
              "Hi Karthik!",
              style: TextStyle(
                  fontSize: 30, color: Color.fromARGB(221, 24, 24, 24)),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 10, right: 10, bottom: 15, left: 10),
            child: Card(
              color: const Color.fromARGB(255, 246, 249, 255),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                        top: 10, right: 10, bottom: 0, left: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Balance",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(221, 24, 24, 24)),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "₹10,000",
                              style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromARGB(221, 24, 24, 24)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                      color: Color.fromARGB(255, 186, 186, 186), thickness: 1),
                  const Padding(
                    padding:
                        EdgeInsets.only(top: 5, right: 10, bottom: 5, left: 10),
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("You've spent",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(221, 24, 24, 24))),
                              Text("left in budget",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(221, 24, 24, 24)))
                            ])
                      ],
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.only(top: 0, right: 10, bottom: 0, left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("500", style: TextStyle(fontSize: 18)),
                        Text("800", style: TextStyle(fontSize: 18))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, right: 10, bottom: 20, left: 10),
                    child: SizedBox(
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            15), // Adjust the value to change the roundness
                        child: LinearProgressIndicator(
                          minHeight: 10,
                          value: usedBudget / totalBudget,
                          // backgroundColor: Color.fromARGB(255, 64, 124, 243),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                              Color.fromARGB(255, 25, 145, 210)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 10, right: 15, bottom: 0, left: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child:
                        Container()), // Add empty expanded widget to push "Show All" to the right
                const Text(
                  "Show All",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(221, 47, 116, 255),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
Expanded(
  flex: 1,
  child: Padding(
    padding: const EdgeInsets.only(top: 5, right: 15, bottom: 0, left: 15),
    child: SingleChildScrollView( // Wrap with SingleChildScrollView
      child: Column(
        children: [
          // Add a ListView for scrollable list of cards
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(), // Prevents scrolling of the ListView
            itemCount: 20, // Replace `yourItemCount` with the actual number of items
            itemBuilder: (context, index) {
              // Replace this with your card widget
              return Card(
                child: Padding(
                  padding: const EdgeInsets.only(top: 5, right: 10, bottom: 5, left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "- ₹400",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 77, 77, 77),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue, // Specify your desired color here
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Text("Entertainment"),
                              )
                            ],
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.delete,
                        color: Color.fromARGB(255, 236, 83, 83),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    ),
  ),
)
,
        ],
      ),
    );
  }
}
