class PasswordJSON {
  final String _tag;
  final String _description;
  final String _password;
  final DateTime _createdOn;

  PasswordJSON(this._tag, this._description, this._password, this._createdOn);

  String getTag() {
    return _tag;
  }

  String getDescription() {
    return _description;
  }

  String getPassword() {
    return _password;
  }

  DateTime getCreatedOn() {
    return _createdOn;
  }
}
