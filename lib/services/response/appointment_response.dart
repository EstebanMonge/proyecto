import 'package:login/services/request/appointment_request.dart';
import 'package:login/models/appointment.dart';

abstract class CreateAppointmentCallBack {
  void onCreateAppointmentSuccess(int appointment);
  void onCreateAppointmentError(String error);
}

abstract class GetAppointmentCallBack {
  void onGetAppointmentSuccess(List<Appointment> appointment);
  void onGetAppointmentError(String error);
}

abstract class DeleteAppointmentCallBack {
  void onDeleteAppointmentSuccess(int appointment);
  void onDeleteAppointmentError(String error);
}

class CreateAppointmentResponse {
  CreateAppointmentCallBack _callBackCreate;
  AppointmentRequest appointmentRequest = new AppointmentRequest();
  CreateAppointmentResponse(this._callBackCreate);

  doCreate(String user_id, service_id, int date ) {
    var fido = Appointment(user_id, service_id, date);

    appointmentRequest
        .createAppointment(fido)
        .then((appointment) => _callBackCreate.onCreateAppointmentSuccess(appointment))
        .catchError((onError) => _callBackCreate.onCreateAppointmentError(onError.toString()));
  }
}

class GetAppointmentResponse {
  GetAppointmentCallBack _callBackGet;
  AppointmentRequest appointmentRequest = new AppointmentRequest();
  GetAppointmentResponse(this._callBackGet);

  doGet() {
    appointmentRequest
        .getAppointment()
        .then((appointment) => _callBackGet.onGetAppointmentSuccess(appointment))
        .catchError((onError) => _callBackGet.onGetAppointmentError(onError.toString()));
  }
}

class DeleteAppointmentResponse {
  DeleteAppointmentCallBack _callBackDelete;
  AppointmentRequest appointmentRequest = new AppointmentRequest();
  DeleteAppointmentResponse(this._callBackDelete);

  doDelete(int id) {

    appointmentRequest
        .deleteAppointment(id)
        .then((appointment) => _callBackDelete.onDeleteAppointmentSuccess(appointment))
        .catchError((onError) => _callBackDelete.onDeleteAppointmentError(onError.toString()));
  }
}