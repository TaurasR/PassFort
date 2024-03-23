import 'package:flutter/material.dart';

import 'package:passfort/views/logins/login_credentials_view.dart';
import 'package:passfort/views/register_view.dart';

import 'package:passfort/assets/widgets/page_background.dart';
import 'package:passfort/assets/widgets/button_wide.dart';

class LoginDefaultView extends StatelessWidget {
  const LoginDefaultView({super.key});

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
              const SizedBox(height: 325),
              ButtonWide(
                text: 'Prisijungti',
                icon: Icons.login,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginWithCredentialsView(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              ButtonWide(
                text: 'Registruotis',
                icon: Icons.edit,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterView(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
