class Appointment {
  int _id;
  String _user_id;
  String _service_id;
  int _date;

  Appointment(this._user_id,this._service_id, this._date);

  Appointment.fromMap(dynamic obj) {
    this._id = obj['id'];
    this._user_id = obj['user_id'];
    this._service_id = obj['service_id'];
    this._date = obj['date'];
  }

  int get id => _id;
  String get user_id => _user_id;
  String get service_id => _service_id;
  int get date => _date;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = _id;
    map["user_id"] = _user_id;
    map["service_id"] = _service_id;
    map["date"] = _date;
    return map;
  }
}