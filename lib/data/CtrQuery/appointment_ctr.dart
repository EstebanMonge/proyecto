import 'package:login/models/appointment.dart';
import 'dart:async';
import 'package:login/data/database_helper.dart';

class AppointmentCtr {
  DatabaseHelper con = new DatabaseHelper();

//insertion
  Future<int> saveAppointment(Appointment appointment) async {
    var dbClient = await con.db;
    int res = await dbClient.insert("Appointment", appointment.toMap());
    return res;
  }

  //deletion
  Future<int> deleteAppointment(int appointment) async {
    var dbClient = await con.db;
    int res = await dbClient.rawDelete('DELETE FROM Appointment WHERE id = ?', [appointment]);
    return res;
  }

  Future<Appointment> checkAppointment(String user_id, String service_id) async {
    var dbClient = await con.db;
    var res = await dbClient.rawQuery("SELECT * FROM appointment WHERE name = '$user_id'");

    if (res.length > 0) {
      return new Appointment.fromMap(res.first);
    }

    return null;
  }

  Future<List<Appointment>> getAllAppointment() async {
    var dbClient = await con.db;
    var res = await dbClient.query("appointment");

    List<Appointment> list =
    res.isNotEmpty ? res.map((c) => Appointment.fromMap(c)).toList() : null;

    return list;
  }
}