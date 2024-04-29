import 'package:flutter/material.dart';
import 'package:passfort/assets/file_operations.dart';
import 'package:passfort/assets/functions.dart';
import 'package:passfort/assets/widgets/page_background.dart';
import 'package:passfort/classes/password.dart';
import 'package:passfort/controllers/main_controller.dart';
import 'package:passfort/views/add_password.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainView();
}

class _MainView extends State<MainView> {
  MainController mainController = MainController();
  String findValue = '';
  List<Password> foundPasswords = <Password>[];

  @override
  void initState() {
    super.initState();
    // FileOperations.deletePasswordsFile();
    // FileOperations.createPasswordsFile();
    FileOperations.readFromPasswordsFile().then((value) => setState(() {
          mainController.setPasswords(getPasswordsFromString(value));
        }));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: PageBackground(
          child: InkWell(
            splashColor: Colors.transparent,
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Center(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: Text(
                      'Slaptažodžiai',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        labelText: 'Ieškoti',
                        labelStyle: const TextStyle(color: Colors.white),
                        hintText: 'Įveskite etiketės pavadinimą',
                        hintStyle: const TextStyle(color: Colors.white),
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          foundPasswords.clear();
                          findValue = value;
                          RegExp regExp = RegExp(value, caseSensitive: false);
                          List<Password> passwords =
                              mainController.getPasswords();
                          for (int i = 0; i < passwords.length; i++) {
                            if (regExp.hasMatch(passwords[i].getName())) {
                              foundPasswords.add(passwords[i]);
                            }
                          }
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: (findValue == '')
                          ? mainController.getPasswordsLength()
                          : foundPasswords.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Password password;
                            if (findValue == '') {
                              password = mainController.getPasswords()[index];
                            } else {
                              password = foundPasswords[index];
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddPasswordView(
                                  updateView: true,
                                  password: password,
                                ),
                              ),
                            );
                          },
                          child: ListTile(
                            title: Text(
                              (findValue == '')
                                  ? '${index + 1}. ${mainController.getPasswords()[index].getName()}'
                                  : '${index + 1}. ${foundPasswords[index].getName()}',
                              style: const TextStyle(color: Colors.white),
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddPasswordView()),
            );
          },
          tooltip: 'Pridėti slaptažodį',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
