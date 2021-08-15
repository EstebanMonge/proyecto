class Service {
  int _id;
  String _name;

  Service(this._name);

  Service.fromMap(dynamic obj) {
    this._id = obj['id'];
    this._name = obj['name'];
  }

  String get name => _name;
  int get id => _id;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = _id;
    map["name"] = _name;
    return map;
  }
}