import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:passfort/assets/database_operations.dart';
import 'package:passfort/assets/file_operations.dart';
import 'package:passfort/assets/functions.dart';
import 'package:passfort/classes/user.dart';

import 'package:passfort/assets/widgets/page_background.dart';
import 'package:passfort/assets/widgets/button_wide.dart';
import 'package:passfort/assets/widgets/text_field_custom.dart';
import 'package:passfort/controllers/login_controller.dart';
import 'package:passfort/views/email_view.dart';
import 'package:passfort/views/main_view.dart';

class LoginWithCredentialsView extends StatelessWidget {
  LoginWithCredentialsView({super.key});

  LoginController loginController = LoginController.empty();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageBackground(
        child: InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 40),
                const Text(
                  textAlign: TextAlign.center,
                  'Prisijungimas',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 50),
                const Text(
                  textAlign: TextAlign.center,
                  'Įveskite vartotojo vardą ir slaptažodį',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                TextFieldCustom(
                  descText: 'Vartotojo vardas',
                  descFontSize: 15,
                  mandatoryField: false,
                  controller: usernameController,
                ),
                const SizedBox(height: 10),
                TextFieldCustom(
                  descText: 'Slaptažodis',
                  mandatoryField: false,
                  controller: passwordController,
                  hideFieldText: true,
                ),
                const SizedBox(height: 50),
                ButtonWide(
                  text: 'Prisijungti',
                  onPressed: () async {
                    loginController.setInfo(
                        usernameController.text, passwordController.text);

                    int status = loginController.getUserInfoStatus();
                    if (status != 0) {
                      loginController.showError(context, status);
                    } else {
                      bool authenticated =
                          await LoginController.authenticateWithFingerprint();

                      if (!await FileOperations.doesFileExist('user.json')) {
                        if (context.mounted) {
                          await showAlertDialogAsync(
                              context, 'Toks vartotojas neegzistuoja.');
                          return;
                        }
                      }
                      final userJson =
                          jsonDecode(await FileOperations.readFromUserFile());
                      User user = User.fromJson(userJson);

                      if (usernameController.text != user.getUsername() ||
                          user.getPassword() !=
                              DatabaseOperations.hashPassword(
                                  passwordController.text)) {
                        if (context.mounted) {
                          await showAlertDialogAsync(
                              context, 'Toks vartotojas neegzistuoja.');
                        }
                      } else {
                        if (context.mounted) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainView(),
                            ),
                          );
                        }
                      }

                      // if (!authenticated) {
                      //   if (context.mounted) {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => const EmailConfirmationView(
                      //             authentification: true,
                      //             createUserIDFile: false),
                      //       ),
                      //     );
                      //   }
                      // }
                    }

                    // final response = await DatabaseOperations.checkCredentials(
                    //     usernameController.text,
                    //     passwordController.text,
                    //     authenticated);
                    // print(response.statusCode);
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
