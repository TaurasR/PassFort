import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:passfort/classes/user.dart';
import 'package:crypto/crypto.dart';
import 'package:passfort/assets/constants.dart' as constants;

class DatabaseOperations {
  const DatabaseOperations();

  static String hashPassword(String password) {
    return sha256.convert(utf8.encode(password)).toString();
  }

  static String _hashPassword(String password) {
    return sha256.convert(utf8.encode(password)).toString();
  }

  static Future<http.Response> insertUser(User user) async {
    String hashedPassword = _hashPassword(user.getPassword());
    return await http.post(
      Uri(
        scheme: constants.serverScheme,
        host: constants.serverHost,
        path: '/register',
        port: constants.serverPort,
      ),
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
  }

  static Future<http.Response> checkCredentials(
      String username, String password, bool authenticated) async {
    String hashedPassword = _hashPassword(password);
    return await http.post(
      Uri(
        scheme: constants.serverScheme,
        host: constants.serverHost,
        path: '/login',
        port: constants.serverPort,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'username': username,
          'password': hashedPassword,
          'bioauth': authenticated.toString(),
        },
      ),
    );
  }

  static Future<http.Response> verifyAuthentication(
      String username, String code) async {
    return await http.post(
      Uri(
        scheme: constants.serverScheme,
        host: constants.serverHost,
        path: '/verifyauth',
        port: constants.serverPort,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'username': username,
          'code': code,
        },
      ),
    );
  }

  static Future<http.Response> generatePassword() async {
    return await http.get(
      Uri(
        scheme: constants.serverScheme,
        host: constants.serverHost,
        path: '/genereatepassword',
        port: constants.serverPort,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }
}
