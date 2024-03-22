import 'package:flutter/material.dart';
import 'package:passfort/models/user_registration.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

import 'package:passfort/views/main_view.dart';

import 'package:passfort/assets/widgets/page_background.dart';
import 'package:passfort/assets/widgets/code_field.dart';
import 'package:passfort/assets/widgets/button_wide.dart';

class EmailConfirmationView extends StatefulWidget {
  final bool authentification;
  final bool createUserIDFile;
  final bool goRouteBeginning;
  final bool registerUser;
  final UserReg user;

  const EmailConfirmationView({
    super.key,
    required this.authentification,
    required this.createUserIDFile,
    this.goRouteBeginning = false,
    this.registerUser = false,
    this.user = const UserReg.empty(),
  });

  @override
  State<EmailConfirmationView> createState() => _EmailConfirmationView();
}

class _EmailConfirmationView extends State<EmailConfirmationView> {
  @override
  void initState() {
    super.initState();
    //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: PageBackground(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 70),
                Text(
                  (widget.authentification)
                      ? 'Autentifikacija elektroniniu paštu'
                      : 'Elektroninio pašto patvirtinimas',
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 150),
                const Text(
                  'Patikrinkite savo elektroninį paštą',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Text(
                  'Įveskite gautą kodą',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                CodeField(),
                const SizedBox(height: 200),
                ButtonWide(
                  text: (widget.authentification) ? 'Tęsti' : 'Patvirtinti',
                  // icon: (widget.authentification)
                  //     ? Icons.arrow_circle_right_outlined
                  //     : Icons.edit,
                  onPressed: () {
                    if (widget.goRouteBeginning) {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainView(),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// void func() async {
  //   var client = HttpClient();
  //   try {
  //     HttpClientRequest request =
  //         await client.post('localhost', 8080, '/verifyauth');
  //     request.headers.set(
  //         HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
  //     request.write('{"userId": "1","code": "123456"}');
  //     // Optionally set up headers...
  //     // Optionally write to the request object...
  //     HttpClientResponse response = await request.close();
  //     // Process the response
  //     final stringData = await response.transform(utf8.decoder).join();
  //     print(stringData);
  //   } finally {
  //     client.close();
  //   }
  // }

  // Future<void> sendPostRequest() async {
  //   var response = await http.post(
  //     Uri(scheme: 'http', host: '10.0.2.2', port: 8080, path: '/verifyauth'),
  //     headers: {"Content-Type": "application/json"},
  //     body: jsonEncode(
  //       {
  //         "userId": '1',
  //         "code": '123456',
  //       },
  //     ),
  //   );
  //   // print(response.body);
  // }