import 'package:flutter/material.dart';

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
