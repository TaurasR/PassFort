// import 'package:flutter/material.dart';
// import 'package:passfort/test_page.dart';

// class RegisterPage extends StatefulWidget {
//   const RegisterPage({super.key});

//   @override
//   State<RegisterPage> createState() => _RegisterPage();
// }

// class _RegisterPage extends State<RegisterPage> {
//   int _buttonSize = 2;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: "PassFort demo (title)",
//       theme: ThemeData(
//         scaffoldBackgroundColor: const Color.fromRGBO(29, 209, 78, 1),
//       ),
//       home: Scaffold(
//         body: Center(
//           child: Column(
//             // crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               const Text(
//                 'Hello World!',
//                 style: TextStyle(
//                   fontSize: 50,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//               const Text(
//                 'We will fight up close, seize the moment and stay in it.',
//               ),
//               Expanded(
//                 child: ListView.separated(
//                   padding: const EdgeInsets.all(8),
//                   //children: //<Widget>[
//                   itemCount: _buttonSize,
//                   itemBuilder: (BuildContext buildContext, int index) {
//                     return ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.red,
//                         foregroundColor: Colors.white,
//                         minimumSize: const Size.fromHeight(50),
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _buttonSize++;
//                           for (int i = 0; i < 5; i++) {
//                             debugPrint('In for loop.');
//                           }
//                         });
//                         debugPrint('Clicked');
//                       },
//                       child: const TestPage(), //const Text('Hiii click me'),
//                     ); //const Center(child: Text('Test 1')),
//                   },
//                   separatorBuilder: (BuildContext context, int index) =>
//                       const Divider(),
//                   //],
//                 ),
//               ),
//               // const Expanded(
//               //   child: Text('Check'),
//               // ),
//               // if (1 == 1) const Text('True') else const Text('False'),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
