import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:path_provider/path_provider.dart';
import 'package:passfort/assets/constants.dart' as constants;
import 'package:passfort/assets/functions.dart';

class LoginController {
  String _username;
  String _password;

  LoginController(this._username, this._password);
  LoginController.empty()
      : _username = '',
        _password = '';

  void setInfo(String username, String password) {
    _username = username;
    _password = password;
  }

  static Future<bool> hasUserPreviouslyLoggedIn() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/${constants.userFilename}');

    if (!file.existsSync()) {
      return false;
    }

    int? id = int.tryParse(file.readAsStringSync());
    if (id == null) {
      return false;
    }

    return true;
  }

  static Future<bool> authenticateWithFingerprint() async {
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
    } on PlatformException {
      return false;
    }

    return authenticated;
  }

  int getUserInfoStatus() {
    int status = _checkForUserEmptyStatus();
    if (status != 0) {
      return status;
    }

    status = _checkUsernameStatus();
    if (status != 0) {
      return status;
    }

    return _checkPasswordStatus();
  }

  int _checkUsernameStatus() {
    if (_username.length < 5) {
      return 6;
    }

    return 0;
  }

  int _checkPasswordStatus() {
    if (_password.length < 8) {
      return 8;
    }

    return 0;
  }

  int _checkForUserEmptyStatus() {
    if (_username.isEmpty) {
      return 3;
    }
    if (_password.isEmpty) {
      return 5;
    }

    return 0;
  }

  void showError(BuildContext context, int error) {
    if (error == 3) {
      showAlertDialog(context, 'Vartotojo vardas negali būti tuščias.');
    } else if (error == 5) {
      showAlertDialog(context, 'Slaptažodis negali būti tuščias.');
    } else if (error == 6) {
      showAlertDialog(
          context, 'Vartotojo vardas turi būti sudarytas bent iš 5 raidžių.');
    } else if (error == 8) {
      showAlertDialog(
          context, 'Slaptažodis turi būti sudarytas bent iš 8 raidžių.');
    }
  }
}
