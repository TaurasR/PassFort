import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:passfort/views/logins/login_auth_view.dart';
import 'package:passfort/views/logins/login_default_view.dart';
import 'package:passfort/controllers/login_controller.dart';
import 'package:passfort/views/main_view.dart';
import 'package:passfort/views/register_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainApp();
}

class _MainApp extends State<MainApp> {
  bool _hasUserPreviouslyLoggedIn = false;

  @override
  void initState() {
    super.initState();
    // LoginController.hasUserPreviouslyLoggedIn().then(
    //   (value) {
    //     setState(() {
    //       _hasUserPreviouslyLoggedIn = value;
    //     });
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'PassFort',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const MainView(),
      // home: (_hasUserPreviouslyLoggedIn)
      //     ? const LoginAuthenticationView()
      //     : const LoginDefaultView(),
    );
  }
}
