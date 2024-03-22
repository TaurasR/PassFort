import 'package:flutter/material.dart';

import 'package:email_validator/email_validator.dart';

import 'package:passfort/models/user_registration.dart';
import 'package:passfort/assets/functions.dart';

class RegisterController {
  UserReg _user;

  RegisterController(this._user);
  RegisterController.empty() : _user = const UserReg.empty();

  void updateUser(UserReg user) {
    _user = user;
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

    status = _checkEmailStatus();
    if (status != 0) {
      return status;
    }

    return _checkPasswordStatus();
  }

  int _checkUsernameStatus() {
    if (_user.getUsername().length < 5) {
      return 6;
    }

    return 0;
  }

  int _checkEmailStatus() {
    if (!EmailValidator.validate(_user.getEmail())) {
      return 7;
    }

    return 0;
  }

  int _checkPasswordStatus() {
    if (_user.getPassword().length < 8) {
      return 8;
    }

    return 0;
  }

  int _checkForUserEmptyStatus() {
    if (_user.getName().isEmpty) {
      return 1;
    }
    if (_user.getLastName().isEmpty) {
      return 2;
    }
    if (_user.getUsername().isEmpty) {
      return 3;
    }
    if (_user.getEmail().isEmpty) {
      return 4;
    }
    if (_user.getPassword().isEmpty) {
      return 5;
    }

    return 0;
  }

  void showError(BuildContext context, int error) {
    if (error == 1) {
      showAlertDialog(context, 'Vardas negali būti tuščias.');
    } else if (error == 2) {
      showAlertDialog(context, 'Pavardė negali būti tuščia.');
    } else if (error == 3) {
      showAlertDialog(context, 'Vartotojo vardas negali būti tuščias.');
    } else if (error == 4) {
      showAlertDialog(context, 'Elektroninis paštas negali būti tuščias.');
    } else if (error == 5) {
      showAlertDialog(context, 'Slaptažodis negali būti tuščias.');
    } else if (error == 6) {
      showAlertDialog(
          context, 'Vartotojo vardas turi būti sudarytas bent iš 5 raidžių.');
    } else if (error == 7) {
      showAlertDialog(
          context, 'Elektroninis paštas neatitinka reikiamo formato.');
    } else if (error == 8) {
      showAlertDialog(
          context, 'Slaptažodis turi būti sudarytas bent iš 8 raidžių.');
    }
  }
}
