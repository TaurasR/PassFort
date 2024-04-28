import 'package:flutter/material.dart';
import 'package:passfort/assets/widgets/page_background.dart';
import 'package:passfort/controllers/main_controller.dart';
import 'package:passfort/views/add_password.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainView();
}

class _MainView extends State<MainView> {
  MainController mainController = MainController();

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
                      onChanged: (value) {},
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: mainController.getPasswordsLength() + 5,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            print('Item $index clicked');
                          },
                          child: ListTile(
                            title: Text(
                              'Slaptžodžio etiketė Nr. ${index + 1}',
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
