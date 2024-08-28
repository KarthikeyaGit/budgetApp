// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:penny/shared/shared.dart';
// import 'dart:async';

// String logo = 'assets/images/logo.svg';

// class GetStarted extends StatefulWidget {
//   const GetStarted({super.key});

//   @override
//   State<GetStarted> createState() => _GetStartedState();
// }

// class _GetStartedState extends State<GetStarted> {
//   final preferencesService = Shared();
//    final TextEditingController _nameController = TextEditingController();
//   int pageIndex = 0;

//   @override
//   void initState() {
//     super.initState();

//     // Show first page after 3 seconds
//     Timer(const Duration(seconds: 3), () {
//       setState(() {
//         pageIndex = 1;
//       });
//     });
//   }

//     Future<void> _loadUsername() async {
//     // Fetch the username using PreferencesService
//     String uname = await preferencesService.get('username');
//     setState(() {
//       _nameController.text = uname; // Assign the username to the controller
//     });
//   }


//   void _nextPage() {
//     print('index: $pageIndex');
//     setState(() {
//       if (pageIndex < 4) {
//         pageIndex++;
//       }
//     });
//   }

//   void _previousPage() {
//     setState(() {
//       if (pageIndex > 1) {
//         pageIndex--;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: const Color(0xFF010304),
//         body: Center(
//           child: _buildPage(),
//         ),
//         floatingActionButton: _buildFloatingButtons(),
//       ),
//     );
//   }

//   Widget _buildPage() {
//     switch (pageIndex) {
//       case 1:
//         return _buildPage1();
//       case 2:
//         // return _buildPage2();
//       case 3:
//         // return _buildPage3();
//       case 4:
//         // return _buildPage4();
//       default:
//         return _buildInitialPage();
//     }
//   }

//   Widget _buildFloatingButtons() {
//     if (pageIndex == 0) {
//       return const SizedBox.shrink();
//     }
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         if (pageIndex > 1)
//           FloatingActionButton(
//             onPressed: _previousPage,
//             child: const Icon(Icons.arrow_back),
//           ),
//         const SizedBox(width: 10),
//         if (pageIndex < 4)
//           FloatingActionButton(
//             onPressed: _nextPage,
//             child: const Icon(Icons.arrow_forward),
//           ),
//       ],
//     );
//   }

//   Widget _buildInitialPage() {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         SvgPicture.asset(
//           logo,
//           semanticsLabel: 'Penny Logo',
//           height: 70,
//         ),
//         const SizedBox(height: 10),
//         const Text(
//           "Penny",
//           style: TextStyle(fontSize: 30, color: Color(0xFFFEFEFE)),
//         ),
//       ],
//     );
//   }

//   Widget _buildPage1() {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 40.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(height: 70),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SvgPicture.asset(
//                 logo,
//                 semanticsLabel: 'Penny Logo',
//                 height: 80,
//               ),
//             ],
//           ),
//           const SizedBox(height: 40),
//           const Text(
//             "Welcome to Penny!",
//             style: TextStyle(fontSize: 24, color: Color(0xFFFEFEFE)),
//           ),
//           const SizedBox(height: 10),
//           const Text(
//             "Easily track your expenses and manage your budget with Penny. Get started on your journey to better financial health today!",
//             style: TextStyle(fontSize: 16, color: Color(0xFFFEFEFE)),
//           ),
//           const SizedBox(height: 20),
//            TextField(
//             controller: _nameController,
//             decoration: const InputDecoration(
//               labelText: 'Enter your name',
//               labelStyle: TextStyle(color: Color.fromARGB(255, 198, 198, 198)),
//               enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Color(0xFF4C4C4C)),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Color(0xFFFEFEFE)),
//               ),
//             ),
//             style: TextStyle(color: Color(0xFFFEFEFE)),
//           ),
//         ],
//       ),
//     );
//   }    
// }
