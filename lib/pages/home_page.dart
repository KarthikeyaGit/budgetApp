import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        onPressed: () {},
        child: const Icon(Icons.add,color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: const SafeArea(
        child: Center(child: Text("hi")))
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
        });
  }
}
