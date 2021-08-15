import 'package:login/models/service.dart';
import 'dart:async';
import 'package:login/data/database_helper.dart';

class ServiceCtr {
  DatabaseHelper con = new DatabaseHelper();

//insertion
  Future<int> saveService(Service service) async {
    var dbClient = await con.db;
    int res = await dbClient.insert("Service", service.toMap());
    return res;
  }

  //deletion
  Future<int> deleteService(int service) async {
    var dbClient = await con.db;
    int res = await dbClient.rawDelete('DELETE FROM Service WHERE id = ?', [service]);
    return res;
  }

  Future<Service> checkService(String name) async {
    var dbClient = await con.db;
    var res = await dbClient.rawQuery("SELECT * FROM service WHERE name = '$name'");

    if (res.length > 0) {
      return new Service.fromMap(res.first);
    }

    return null;
  }

  Future<List<Service>> getAllService() async {
    var dbClient = await con.db;
    var res = await dbClient.query("service");

    List<Service> list =
    res.isNotEmpty ? res.map((c) => Service.fromMap(c)).toList() : null;

    return list;
  }
}