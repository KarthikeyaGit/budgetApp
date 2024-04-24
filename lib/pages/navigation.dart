import 'package:budgetapp/pages/analytics_page.dart';
import 'package:budgetapp/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: getTabs(),
      floatingActionButton: FloatingActionButton(
        focusColor: Colors.blue.shade700,
        backgroundColor: Colors.blue.shade600,
        shape: const CircleBorder(eccentricity: BorderSide.strokeAlignCenter),
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return addMoney();
            },
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: pageIndex == 0
          ? const HomePage()
          : (pageIndex == 1 ? const AnalyticsPage() : Container()),
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
      onTap: (int index) {
        setState(() {
          print("index: $index"); // Concatenate index with the string
          pageIndex = index;
        });
      },
    );
  }

  Widget addMoney() {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 4,
            width: 60,
            color: Colors.black38,
          ),
          
        ],
      ),
    );
  }
}
