class Password {
  final int _id;
  final int _userID;
  final String _password;
  final String _username;
  final String _website;
  final String _name;

  Password(this._id, this._userID, this._password, this._username,
      this._website, this._name);

  Password.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _userID = json['user_id'],
        _password = json['password'],
        _username = json['username'],
        _website = json['website'],
        _name = json['name'];

  Map<String, dynamic> toJson() => {
        'id': _id,
        'user_id': _userID,
        'password': _password,
        'username': _username,
        'website': _website,
        'name': _name
      };

  int getID() {
    return _id;
  }

  int getUserID() {
    return _userID;
  }

  String getPassword() {
    return _password;
  }

  String getUsername() {
    return _username;
  }

  String getWebsite() {
    return _website;
  }

  String getName() {
    return _name;
  }
}
