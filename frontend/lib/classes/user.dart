class User {
  final int _id;
  final String _name;
  final String _lastName;
  final String _username;
  final String _email;
  final String _password;
  final String _decryptionKey;

  User(this._id, this._name, this._lastName, this._username, this._email,
      this._password, this._decryptionKey);
  const User.empty()
      : _id = -1,
        _name = '',
        _lastName = '',
        _username = '',
        _email = '',
        _password = '',
        _decryptionKey = '';

  int getID() {
    return _id;
  }

  String getName() {
    return _name;
  }

  String getLastName() {
    return _lastName;
  }

  String getUsername() {
    return _username;
  }

  String getEmail() {
    return _email;
  }

  String getPassword() {
    return _password;
  }

  String getDecryptionKey() {
    return _decryptionKey;
  }
}
