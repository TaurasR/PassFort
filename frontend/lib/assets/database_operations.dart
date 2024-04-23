import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:passfort/classes/user.dart';
import 'package:crypto/crypto.dart';

class DatabaseOperations {
  const DatabaseOperations();

  static String _hashPassword(String password) {
    return sha256.convert(utf8.encode(password)).toString();
  }

  static Future<int> insertUser(User user) async {
    String hashedPassword = _hashPassword(user.getPassword());
    final response = await http.post(
      Uri(),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'username': user.getUsername(),
          'password': hashedPassword,
          'name': user.getName(),
          'surname': user.getLastName(),
          'email': user.getEmail(),
          'decryption_key': user.getDecryptionKey(),
        },
      ),
    );

    return response.statusCode;
  }
}
