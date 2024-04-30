import 'package:passfort/assets/functions.dart';
import 'package:passfort/classes/password.dart';
import 'package:test/test.dart';

void main() {
  test('Passwordu gavimas', () async {
    Password password1 = Password(1, 1, 'Petras123', 'Petras', 'https://www.ea.com/', 'EA');
    Password password2 = Password(2, 1, 'Petras430', 'Petras', 'https://steamcommunity.com/', 'Steam');
    Password password3 = Password(2, 1, 'Petras430', 'Petras', 'https://steamcommunity.com/', 'Steam');

    List<Password> localPasswords = [password1];
    List<Password> dbPasswords = [password2, password3];
    
    List<Password> allPasswords = await getAllPasswords(localPasswords, dbPasswords);

    expect(allPasswords.length, 2);
    expect(allPasswords[0].getName(), 'EA');
    expect(allPasswords[1].getName(), 'Steam');
  });
}