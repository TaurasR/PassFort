import 'package:flutter/material.dart';
import 'package:passfort/controllers/login_controller.dart';

import 'package:passfort/views/email_view.dart';
import 'package:passfort/views/main_view.dart';

import 'package:passfort/assets/widgets/page_background.dart';
import 'package:passfort/assets/widgets/button_wide.dart';

class LoginAuthenticationView extends StatelessWidget {
  const LoginAuthenticationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageBackground(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 150),
              const Text(
                'PassFort',
                style: TextStyle(
                  fontSize: 85,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Text(
                'Daugiau nepamirškite savo slaptažodžių',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 270),
              const Text(
                'Sveiki sugrįžę',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                'Norint tęsti, reikalinga autentifikacija',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              const SizedBox(height: 40),
              ButtonWide(
                text: 'Piršto antspaudas',
                icon: Icons.fingerprint,
                onPressed: () async {
                  if (await LoginController.authenticateWithFingerptint()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainView(),
                      ),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (buildContext) {
                        return AlertDialog(
                          titleTextStyle: const TextStyle(
                            fontSize: 21,
                            color: Colors.black,
                          ),
                          title: const Row(
                            children: [
                              Text('Autentifikacija nesėkminga'),
                              Text(' '),
                              Icon(
                                Icons.error,
                                color: Color.fromARGB(255, 202, 17, 17),
                              ),
                            ],
                          ),
                          content: const Text(
                              'Ar norite autentifikuotis per elektroninį paštą?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Ne'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const EmailConfirmationView(
                                      authentification: true,
                                      createUserIDFile: false,
                                      goRouteBeginning: true,
                                    ),
                                  ),
                                );
                              },
                              child: const Text('Taip'),
                            )
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
