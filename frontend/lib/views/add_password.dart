import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:passfort/assets/database_operations.dart';
import 'package:passfort/assets/file_operations.dart';
import 'package:passfort/assets/functions.dart';
import 'package:passfort/assets/widgets/button_wide.dart';
import 'package:passfort/assets/widgets/page_background.dart';
import 'package:passfort/assets/widgets/text_field_custom.dart';
import 'package:passfort/classes/password.dart';
import 'package:passfort/views/main_view.dart';

class AddPasswordView extends StatefulWidget {
  const AddPasswordView({super.key, this.updateView = false, this.password});

  final bool updateView;
  final Password? password;

  @override
  State<AddPasswordView> createState() => _AddPasswordView();
}

class _AddPasswordView extends State<AddPasswordView> {
  bool showPassword = true;
  bool localSave = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.updateView) {
      setState(() {
        nameController.text = widget.password!.getName();
        usernameController.text = widget.password!.getUsername();
        websiteController.text = widget.password!.getWebsite();
        passwordController.text = widget.password!.getPassword();
        showPassword = false;
        localSave = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: (widget.updateView)
            ? const Text('Slaptažodžio atnaujinimas')
            : const Text('Naujo slaptažodžio pridėjimas'),
        backgroundColor: const Color.fromARGB(255, 35, 128, 77),
        foregroundColor: Colors.white,
      ),
      body: PageBackground(
        child: InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                TextFieldCustom(
                  descFontSize: 18,
                  descText: 'Etiketės pavadinimas',
                  controller: nameController,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFieldCustom(
                  descFontSize: 18,
                  descText: 'Vartotojo vardas',
                  controller: usernameController,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFieldCustom(
                  descFontSize: 18,
                  descText: 'Svetainės pavadinimas',
                  controller: websiteController,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFieldCustom(
                  descFontSize: 18,
                  descText: 'Slaptažodis',
                  controller: passwordController,
                  hideFieldText: !showPassword,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ButtonWide(
                      text: 'Pasiūlyti slaptažodį',
                      textSize: 14,
                      buttonWidth: 180,
                      onPressed: () async {
                        final response =
                            await DatabaseOperations.generatePassword();
                        if (response.statusCode == 200) {
                          passwordController.text =
                              jsonDecode(response.body)['password'];
                        }
                      },
                    ),
                    const SizedBox(
                      width: 60,
                    ),
                    const Text(
                      'Rodyti',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    Transform.scale(
                      scale: 1.7,
                      child: Checkbox(
                        side: MaterialStateBorderSide.resolveWith(
                          (states) =>
                              const BorderSide(width: 1.0, color: Colors.white),
                        ),
                        value: showPassword,
                        onChanged: (bool? value) {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 27,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'Saugoti slaptažodį lokaliai',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    Transform.scale(
                      scale: 1.7,
                      child: Checkbox(
                        side: MaterialStateBorderSide.resolveWith(
                          (states) =>
                              const BorderSide(width: 1.0, color: Colors.white),
                        ),
                        value: localSave,
                        onChanged: (bool? value) {
                          setState(() {
                            localSave = !localSave;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                ButtonWide(
                  text: (widget.updateView) ? 'Atnaujinti' : 'Pridėti',
                  onPressed: () async {
                    if (nameController.text.isEmpty) {
                      showAlertDialog(
                          context, 'Etiketės pavadinimas negali būti tuščias.');
                      return;
                    }
                    if (usernameController.text.isEmpty) {
                      showAlertDialog(
                          context, 'Vartotojo vardas negali būti tuščias.');
                      return;
                    }
                    if (websiteController.text.isEmpty) {
                      showAlertDialog(context,
                          'Svetainės pavadinimas negali būti tuščias.');
                      return;
                    }
                    if (passwordController.text.isEmpty) {
                      showAlertDialog(
                          context, 'Slaptažodis negali būti tuščias.');
                      return;
                    }

                    if (widget.updateView) {
                      widget.password!.setName(nameController.text);
                      widget.password!.setPassword(passwordController.text);
                      widget.password!.setWebsite(websiteController.text);
                      widget.password!.setUsername(usernameController.text);

                      String data =
                          await FileOperations.readFromPasswordsFile();
                      List<Password> passwords = getPasswordsFromString(data);

                      passwords =
                          removePassword(passwords, widget.password!.getID());

                      passwords = addPassword(passwords, widget.password!);

                      String prettyJSON = getPrettyJSONString(
                          jsonDecode(jsonEncodePasswords(passwords)));

                      await FileOperations.writeToPasswordsFile(prettyJSON);
                    } else {
                      if (localSave) {
                        String data =
                            await FileOperations.readFromPasswordsFile();
                        List<Password> passwords = getPasswordsFromString(data);

                        int id = (passwords.isEmpty)
                            ? 1
                            : passwords.last.getID() + 1;
                        Password password = Password(
                          id,
                          1,
                          passwordController.text,
                          usernameController.text,
                          websiteController.text,
                          nameController.text,
                        );

                        passwords = addPassword(passwords, password);
                        String prettyJSON = getPrettyJSONString(
                            jsonDecode(jsonEncodePasswords(passwords)));

                        await FileOperations.writeToPasswordsFile(prettyJSON);
                      }
                    }

                    if (context.mounted) {
                      // Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainView()),
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
