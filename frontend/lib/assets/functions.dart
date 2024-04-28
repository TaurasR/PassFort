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
    passwords.add(Password.fromJson(jsonDecode(passwordsList.elementAt(i))));
  }

  return passwords;
}
