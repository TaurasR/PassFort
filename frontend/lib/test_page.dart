// import 'package:flutter/material.dart';
// import 'package:passfort/root_login.dart';
// import 'package:provider/provider.dart';

// class TestPage extends StatefulWidget {
//   const TestPage({super.key});

//   @override
//   State<TestPage> createState() => _TestPage();
// }

// class _TestPage extends State<TestPage> {
//   @override
//   Widget build(BuildContext context) {
//     var appstate = context.watch<MyAppState>();

//     return Scaffold(
//       body: Center(
//         child: Column(
//           children: [
//             const Text(
//               'Hello World! [1]',
//               style: TextStyle(
//                 fontSize: 50,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 appstate.page = 'test_page_2';
//               },
//               child: const Text('Click me'),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class TestPage2 extends StatefulWidget {
//   const TestPage2({super.key});

//   @override
//   State<TestPage2> createState() => _TestPage2State();
// }

// class _TestPage2State extends State<TestPage2> {
//   @override
//   Widget build(BuildContext context) {
//     var appstate = context.watch<MyAppState>();

//     return Scaffold(
//       body: Center(
//         child: Column(
//           children: [
//             const Text(
//               'Hello World! [2]',
//               style: TextStyle(
//                 fontSize: 50,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 appstate.page = 'test_page_1';
//               },
//               child: const Text('Click me'),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
