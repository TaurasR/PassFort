class Password {
  final int _id;
  final int _userID;
  String _password;
  String _username;
  String _website;
  String _name;

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

  void setPassword(String password) {
    _password = password;
  }

  String getUsername() {
    return _username;
  }

  void setUsername(String username) {
    _username = username;
  }

  String getWebsite() {
    return _website;
  }

  void setWebsite(String website) {
    _website = website;
  }

  String getName() {
    return _name;
  }

  void setName(String name) {
    _name = name;
  }

  @override
  String toString() {
    return 'ID: $_id, UserID: $_userID, Password: $_password, Username: $_username, Website: $_website, Name: $_name';
  }
}
