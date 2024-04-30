import 'package:passfort/assets/functions.dart';
import 'package:passfort/classes/user.dart';
import 'package:test/test.dart';

void main() {
  test('userio gavimas', () {
    String jsonString = '''{
    "id": 1,
    "name": "Petras",
    "surname": "Petrauskas",
    "username": "Petras",
    "email": "Petras@gmail.com",
    "password": "Petras123",
    "decryption_key": "key"
}''';
    User user = getUserFromString(jsonString);

    expect(user.getID(), 1);
    expect(user.getName(), 'Petras');
    expect(user.getLastName(), 'Petrauskas');
    expect(user.getUsername(), 'Petras');
    expect(user.getEmail(), 'Petras@gmail.com');
    expect(user.getPassword(), 'Petras123');
    expect(user.getDecryptionKey(), 'key');
  });
}