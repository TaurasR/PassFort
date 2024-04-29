import 'dart:core';
import 'package:passfort/classes/password.dart';

class MainController {
  final _passwords = <Password>[];

  MainController();

  List<Password> getPasswords() {
    return _passwords;
  }

  int getPasswordsLength() {
    return _passwords.length;
  }

  void setPasswords(List<Password> passwords) {
    _passwords.clear();
    _passwords.addAll(passwords);
  }
}
