import 'package:passfort/classes/password_json.dart';

class Login {
  int? _userID;
  List<PasswordJSON>? _passwords;

  Login();

  int? getUserID() {
    return _userID;
  }

  List<PasswordJSON>? getPasswords() {
    return _passwords;
  }
}
