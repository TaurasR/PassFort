class UserReg {
  final String _name;
  final String _lastName;
  final String _username;
  final String _email;
  final String _password;

  UserReg(
      this._name, this._lastName, this._username, this._email, this._password);
  const UserReg.empty()
      : _name = '',
        _lastName = '',
        _username = '',
        _email = '',
        _password = '';

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
}
