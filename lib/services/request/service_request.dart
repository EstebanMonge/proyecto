import 'dart:async';

import 'package:login/models/service.dart';
import 'package:login/data/CtrQuery/service_ctr.dart';

class ServiceRequest {
  ServiceCtr con = new ServiceCtr();

  Future<int> createService(Service service) {
    var result = con.saveService(service);
    return result;
  }

  Future<List<Service>> getService() {
    var result = con.getAllService();
    return result;
  }

  Future<int> deleteService(int service) {
    var result = con.deleteService(service);
    return result;
  }
}