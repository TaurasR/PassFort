import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:passfort/assets/constants.dart' as constants;
import 'package:path_provider/path_provider.dart';

class FileOperations {
  const FileOperations();

  static Future<bool> hasUserPreviouslyLoggedIn() async {
    return await doesFileExist('user.json');
  }

  static Future<void> createUserFile() async {
    if (await doesFileExist(constants.userFilename)) {
      debugPrint('${constants.userFilename} already exists.');
      return;
    }

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/${constants.userFilename}');

    await file.create();
  }

  static Future<void> createPasswordsFile() async {
    if (await doesFileExist(constants.passwordsFilename)) {
      debugPrint('${constants.passwordsFilename} already exists.');
      return;
    }

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/${constants.passwordsFilename}');

    await file.create();

    await file.writeAsString('{"passwords": []}');
  }

  static Future<void> deleteUserFile() async {
    if (!await doesFileExist(constants.userFilename)) {
      debugPrint('${constants.userFilename} does not exist.');
      return;
    }

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/${constants.userFilename}');

    await file.delete();
  }

  static Future<void> deletePasswordsFile() async {
    if (!await doesFileExist(constants.passwordsFilename)) {
      debugPrint('${constants.passwordsFilename} does not exist.');
      return;
    }

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/${constants.passwordsFilename}');

    await file.delete();
  }

  static Future<bool> doesFileExist(String filename) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$filename');

    return await file.exists();
  }

  static Future<void> listFiles() async {
    final directory = await getApplicationDocumentsDirectory();
    final files = await directory.list().toList();
    debugPrint(files.toString());
  }

  static Future<void> writeToUserFile(String data) async {
    if (!await doesFileExist(constants.userFilename)) {
      debugPrint('${constants.userFilename} does not exist.');
      return;
    }

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/${constants.userFilename}');

    await file.writeAsString(data);
  }

  static Future<void> writeToPasswordsFile(String data) async {
    if (!await doesFileExist(constants.passwordsFilename)) {
      debugPrint('${constants.passwordsFilename} does not exist.');
      return;
    }

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/${constants.passwordsFilename}');

    await file.writeAsString(data);
  }

  static Future<String> readFromUserFile() async {
    if (!await doesFileExist(constants.userFilename)) {
      debugPrint('${constants.userFilename} does not exist.');
      return '';
    }

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/${constants.userFilename}');

    return await file.readAsString();
  }

  static Future<String> readFromPasswordsFile() async {
    if (!await doesFileExist(constants.passwordsFilename)) {
      debugPrint('${constants.passwordsFilename} does not exist.');
      return '';
    }

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/${constants.passwordsFilename}');

    return await file.readAsString();
  }
}
