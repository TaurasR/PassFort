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

class AddPasswordView extends StatefulWidget {
  const AddPasswordView({super.key});

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
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Naujo slaptažodžio pridėjimas'),
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
                  text: 'Pridėti',
                  onPressed: () async {
                    // if (nameController.text.isEmpty) {
                    //   showAlertDialog(
                    //       context, 'Etiketės pavadinimas negali būti tuščias.');
                    //   return;
                    // }
                    // if (usernameController.text.isEmpty) {
                    //   showAlertDialog(
                    //       context, 'Vartotojo vardas negali būti tuščias.');
                    //   return;
                    // }
                    // if (websiteController.text.isEmpty) {
                    //   showAlertDialog(context,
                    //       'Svetainės pavadinimas negali būti tuščias.');
                    //   return;
                    // }
                    // if (passwordController.text.isEmpty) {
                    //   showAlertDialog(
                    //       context, 'Slaptažodis negali būti tuščias.');
                    //   return;
                    // }
                    Password password = Password(
                        1,
                        1,
                        passwordController.text,
                        usernameController.text,
                        websiteController.text,
                        nameController.text);

                    // await FileOperations.createPasswordsFile();
                    // await FileOperations.deleteFile('passwords.json');
                    // await FileOperations.writeToFile(
                    //     'passwords.json', jsonEncode(password.toJson()));
                    // if (localSave) {}
                    // final res = jsonDecode(
                    // await FileOperations.readFromFile('passwords.json'));
                    // print(res['passwords']);
                    // print(await FileOperations.readFromFile('passwords.json'));
                    // Navigator.pop(context);

                    // const filename = 'user.json';
                    // const data = {'user_id': 1};
                    // await FileOperations.createFile(filename);
                    // await FileOperations.writeToFile(
                    //     filename, jsonEncode(data));
                    // print(await FileOperations.doesFileExist(filename));
                    // String data = await FileOperations.readFromFile(filename);
                    // print(data);
                    // await FileOperations.deleteFile(filename);
                    // print(jsonDecode(data));
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
