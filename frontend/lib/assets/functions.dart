import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:passfort/classes/password.dart';

void showAlertDialog(BuildContext context, String text) {
  showDialog(
    context: context,
    builder: (BuildContext buildContext) {
      return AlertDialog(
        title: const Row(
          children: [
            Text('Pranešimas'),
            Text(' '),
            Icon(
              Icons.warning,
              color: Color.fromARGB(255, 148, 135, 23),
            ),
          ],
        ),
        content: Text(text),
      );
    },
  );
}

Future<void> showAlertDialogAsync(BuildContext context, String text) async {
  await showDialog(
    context: context,
    builder: (BuildContext buildContext) {
      return AlertDialog(
        title: const Row(
          children: [
            Text('Pranešimas'),
            Text(' '),
            Icon(
              Icons.warning,
              color: Color.fromARGB(255, 148, 135, 23),
            ),
          ],
        ),
        content: Text(text),
      );
    },
  );
}

String jsonEncodePasswords(List<Password> passwords) {
  String text = '{"passwords": [';

  for (int i = 0; i < passwords.length; i++) {
    text += jsonEncode(passwords.elementAt(i).toJson());
    if (i != passwords.length - 1) {
      text += ',';
    }
  }
  text += ']}';

  return text;
}

List<Password> getPasswordsFromString(String data) {
  final passwords = <Password>[];

  final text = jsonDecode(data);
  final List<dynamic> passwordsList = text['passwords'];

  for (int i = 0; i < passwordsList.length; i++) {
    passwords.add(Password.fromJson(passwordsList[i]));
  }

  return passwords;
}

List<Password> addPassword(List<Password> passwords, Password password) {
  passwords.add(password);
  return passwords;
}

List<Password> removePassword(List<Password> passwords, int id) {
  for (int i = 0; i < passwords.length; i++) {
    if (passwords[i].getID() == id) {
      passwords.removeAt(i);
      break;
    }
  }
  return passwords;
}

String getPrettyJSONString(Map<String, dynamic> jsonObject) {
  var encoder = const JsonEncoder.withIndent('  ');
  return encoder.convert(jsonObject);
}

// void main() async {
//   final file = File('passwords.json');
//   String data = await file.readAsString();

//   List<Password> passwords = getPasswordsFromString(data);
//   for (int i = 0; i < passwords.length; i++) {
//     print(passwords[i].toString());
//   }
//   Password p = Password(0, 0, 'c', 'c', 'c', 'c');
//   passwords = addPassword(passwords, p);

//   String w = getPrettyJSONString(jsonDecode(jsonEncodePasswords(passwords)));

//   file.writeAsString(w + '\n');
// }
