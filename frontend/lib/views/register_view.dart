import 'package:flutter/material.dart';
import 'package:passfort/assets/database_operations.dart';
import 'package:passfort/assets/functions.dart';
import 'package:passfort/controllers/register_controller.dart';
import 'package:passfort/assets/widgets/page_background.dart';
import 'package:passfort/assets/widgets/button_wide.dart';
import 'package:passfort/assets/widgets/text_field_custom.dart';
import 'package:passfort/classes/user.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterView();
}

class _RegisterView extends State<RegisterView> {
  RegisterController registerController = RegisterController.empty();

  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    lastNameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

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
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                const Center(
                  child: Text(
                    'Registracija',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextFieldCustom(descText: 'Vardas', controller: nameController),
                const SizedBox(height: 10),
                TextFieldCustom(
                    descText: 'Pavardė', controller: lastNameController),
                const SizedBox(height: 10),
                TextFieldCustom(
                    descText: 'Vartotojo vardas',
                    controller: usernameController),
                const SizedBox(height: 10),
                TextFieldCustom(
                    descText: 'Elektroninis paštas',
                    controller: emailController),
                const SizedBox(height: 10),
                TextFieldCustom(
                  descText: 'Slaptažodis',
                  controller: passwordController,
                  hideFieldText: true,
                ),
                const SizedBox(height: 50),
                Center(
                  child: ButtonWide(
                    text: 'Prisiregistruoti',
                    onPressed: () async {
                      nameController.text = 'Justas';
                      lastNameController.text = 'J';
                      usernameController.text = 'Justas';
                      emailController.text = 'justasjjustas@gmail.com';
                      passwordController.text = 'justas123';

                      User user = User(
                        -1, // Does not matter
                        nameController.text,
                        lastNameController.text,
                        usernameController.text,
                        emailController.text,
                        passwordController.text,
                        usernameController
                            .text, // Decryption key same as username
                      );
                      registerController.updateUser(user);

                      int status = registerController.getUserInfoStatus();
                      if (status != 0) {
                        registerController.showError(context, status);
                      } else {
                        final response =
                            await DatabaseOperations.insertUser(user);
                        if (response.statusCode == 200 && context.mounted) {
                          await showAlertDialogAsync(
                              context, 'Registracija sėkminga!');
                          if (context.mounted) {
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
                          }
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
