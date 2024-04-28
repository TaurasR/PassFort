import 'package:passfort/classes/password.dart';

class Login {
  int? _userID;
  List<Password>? _passwords;

  Login();

  int? getUserID() {
    return _userID;
  }

  List<Password>? getPasswords() {
    return _passwords;
  }
}
