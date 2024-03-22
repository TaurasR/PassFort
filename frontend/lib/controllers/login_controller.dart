import 'dart:io';

import 'package:flutter/services.dart';

import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:path_provider/path_provider.dart';

import 'package:passfort/models/login_model.dart';
import 'package:passfort/assets/constants.dart' as constants;

class LoginController {
  Login login = Login();

  LoginController();

  Future<bool> hasUserPreviouslyLoggedIn() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/${constants.userIDFilename}');

    if (!file.existsSync()) {
      return false;
    }

    int? id = int.tryParse(file.readAsStringSync());
    if (id == null) {
      return false;
    }

    return true;
  }

  static Future<bool> authenticateWithFingerptint() async {
    bool authenticated = false;
    LocalAuthentication auth = LocalAuthentication();

    try {
      authenticated = await auth.authenticate(
        localizedReason: 'Nuskenuokite savo piršto antspaudą',
        options: const AuthenticationOptions(
          stickyAuth: false,
          biometricOnly: true,
        ),
        authMessages: const <AuthMessages>[
          AndroidAuthMessages(
            signInTitle: 'Prisijungimas',
            cancelButton: 'Atšaukti',
            biometricHint: 'Patvirtinkite tapatybę',
          ),
        ],
      );
    } on PlatformException catch (e) {
      print(e);
      return false;
    }

    return authenticated;
  }
}
