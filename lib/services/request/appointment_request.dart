import 'dart:async';

import 'package:login/models/appointment.dart';
import 'package:login/data/CtrQuery/appointment_ctr.dart';

class AppointmentRequest {
  AppointmentCtr con = new AppointmentCtr();

  Future<int> createAppointment(Appointment appointment) {
    var result = con.saveAppointment(appointment);
    return result;
  }

  Future<List<Appointment>> getAppointment() {
    var result = con.getAllAppointment();
    return result;
  }

  Future<int> deleteAppointment(int appointment) {
    var result = con.deleteAppointment(appointment);
    return result;
  }
}