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

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: getTabs(),
      floatingActionButton: FloatingActionButton(
        focusColor: Colors.blue.shade700,
        backgroundColor: Colors.blue.shade600,
        shape: const CircleBorder(eccentricity: BorderSide.strokeAlignCenter),
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
             padding: EdgeInsets.only(top:10, right:15, bottom:0, left:15),
              child: Text(
                "Hi Karthik!",
                style: TextStyle(
                    fontSize: 30, color: Color.fromARGB(221, 49, 47, 47)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top:10, right:15, bottom:15, left:15),
              child: Card(
                color: Color.fromARGB(255, 246, 249, 255),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top:10, right:10, bottom:5, left:10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [ Text("You've spent", style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color:  Color.fromARGB(221, 49, 47, 47)),),
                        Text("left in budget", style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color:  Color.fromARGB(221, 49, 47, 47)))],
                      ),
                    ),
                     const Padding(
                      padding: EdgeInsets.only(top:0, right:10, bottom:5, left:10),
                       child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [ Text("500", style: TextStyle(fontSize: 17)),
                        Text("800", style: TextStyle(fontSize: 17))],
                                         ),
                     ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              15), // Adjust the value to change the roundness
                          child: LinearProgressIndicator(
                            minHeight: 10,
                            value: usedBudget / totalBudget,
                            backgroundColor: Colors.grey[300],
                            valueColor:
                                const AlwaysStoppedAnimation<Color>(Colors.blue),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Padding(
            //   padding: const EdgeInsets.all(20.0),
            //   child: SizedBox(
            //     width: double.infinity, // Set width to fill available space
            //     height: 300, // Fixed height
            //     child: AnimatedSwitcher(
            //       duration: const Duration(milliseconds: 500),
            //       child:
            //           pageIndex == 0 ? buildFirstChart() : buildSecondChart(),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget getTabs() {
    List<IconData> iconsItems = [
      Icons.dashboard_rounded,
      Icons.bar_chart_sharp,
    ];
    return AnimatedBottomNavigationBar(
      icons: iconsItems,
      activeIndex: pageIndex,
      activeColor: Colors.blue.shade600,
      inactiveColor: Colors.grey.shade500,
      gapLocation: GapLocation.center,
      onTap: (index) {
        setState(() {
          pageIndex = index;
        });
      },
    );
  }

  Widget buildFirstChart() {
    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
            value: 40,
            color: Colors.red,
            title: '40%',
            radius: 50,
            titleStyle: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          PieChartSectionData(
            value: 30,
            color: Colors.blue,
            title: '30%',
            radius: 50,
            titleStyle: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          PieChartSectionData(
            value: 30,
            color: Colors.green,
            title: '30%',
            radius: 50,
            titleStyle: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget buildSecondChart() {
    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
            value: 20,
            color: Colors.yellow,
            title: '20%',
            radius: 50,
            titleStyle: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          PieChartSectionData(
            value: 40,
            color: Colors.orange,
            title: '40%',
            radius: 50,
            titleStyle: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          PieChartSectionData(
            value: 40,
            color: Colors.purple,
            title: '40%',
            radius: 50,
            titleStyle: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
