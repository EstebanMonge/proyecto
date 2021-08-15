class User {
  int _id;
  String _username;
  String _password;
  String _name;
  String _lastname;
  String _surname;
  String _email;
  String _phone;
  int _birthdate;

  User(this._username, this._password, this._name, this._lastname, this._surname, this._email, this._phone, this._birthdate);

  User.fromMap(dynamic obj) {
    this._id = obj['id'];
    this._username = obj['username'];
    this._password = obj['password'];
    this._name = obj['name'];
    this._lastname = obj['lastname'];
    this._surname = obj['surname'];
    this._email = obj['email'];
    this._phone = obj['phone'];
    this._birthdate = obj['birthdate'];
  }

  String get username => _username;
  String get password => _password;
  String get name => _name;
  String get lastname => _lastname;
  String get surname => _surname;
  String get email => _email;
  String get phone => _phone;
  int get id => _id;
  int get birthdate => _birthdate;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = _id;
    map["username"] = _username;
    map["password"] = _password;
    map["name"] = _name;
    map["lastname"] = _lastname;
    map["surname"] = _surname;
    map["email"] = _email;
    map["phone"] = _phone;
    map["birthdate"] = _birthdate;
    return map;
  }
}