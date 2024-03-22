import 'package:flutter/material.dart';

import 'package:passfort/views/email_view.dart';

import 'package:passfort/controllers/register_controller.dart';

import 'package:passfort/assets/widgets/page_background.dart';
import 'package:passfort/assets/widgets/button_wide.dart';
import 'package:passfort/assets/widgets/text_field_custom.dart';

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
                    hintText: 'abc@def.gh',
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
                    onPressed: () {
                      // UserReg user = UserReg(
                      //   nameController.text,
                      //   lastNameController.text,
                      //   usernameController.text,
                      //   emailController.text,
                      //   passwordController.text,
                      // );
                      // registerController.updateUser(user);

                      // int status = registerController.getUserInfoStatus();
                      // if (status != 0) {
                      //   registerController.showError(context, status);
                      // } else {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => EmailConfirmationView(
                      //         authentification: false,
                      //         createUserIDFile: false,
                      //         goRouteBeginning: true,
                      //         registerUser: true,
                      //         user: user,
                      //       ),
                      //     ),
                      //   );
                      // }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EmailConfirmationView(
                            authentification: false,
                            createUserIDFile: false,
                            goRouteBeginning: true,
                          ),
                        ),
                      );
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
