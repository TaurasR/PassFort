import 'package:flutter/material.dart';

import 'package:passfort/views/email_view.dart';

import 'package:passfort/assets/widgets/page_background.dart';
import 'package:passfort/assets/widgets/button_wide.dart';
import 'package:passfort/assets/widgets/text_field_custom.dart';

class LoginWithCredentialsView extends StatelessWidget {
  LoginWithCredentialsView({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  // final emailContrl = EmailController();

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
                  onPressed: () {
                    // emailContrl.createUserIDFile();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EmailConfirmationView(
                          authentification: false,
                          createUserIDFile: false,
                        ),
                      ),
                    );
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
