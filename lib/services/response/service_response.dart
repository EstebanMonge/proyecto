import 'package:login/services/request/service_request.dart';
import 'package:login/models/service.dart';

abstract class CreateServiceCallBack {
  void onCreateServiceSuccess(int service);
  void onCreateServiceError(String error);
}

abstract class GetServiceCallBack {
  void onGetServiceSuccess(List<Service> service);
  void onGetServiceError(String error);
}

abstract class DeleteServiceCallBack {
  void onDeleteServiceSuccess(int service);
  void onDeleteServiceError(String error);
}

class CreateServiceResponse {
  CreateServiceCallBack _callBackCreate;
  ServiceRequest serviceRequest = new ServiceRequest();
  CreateServiceResponse(this._callBackCreate);

  doCreate(String name) {
    var fido = Service(name);

    serviceRequest
        .createService(fido)
        .then((service) => _callBackCreate.onCreateServiceSuccess(service))
        .catchError((onError) => _callBackCreate.onCreateServiceError(onError.toString()));
  }
}

class GetServiceResponse {
  GetServiceCallBack _callBackGet;
  ServiceRequest serviceRequest = new ServiceRequest();
  GetServiceResponse(this._callBackGet);

  doGet() {
    serviceRequest
        .getService()
        .then((service) => _callBackGet.onGetServiceSuccess(service))
        .catchError((onError) => _callBackGet.onGetServiceError(onError.toString()));
  }
}

class DeleteServiceResponse {
  DeleteServiceCallBack _callBackDelete;
  ServiceRequest serviceRequest = new ServiceRequest();
  DeleteServiceResponse(this._callBackDelete);

  doDelete(int id) {

    serviceRequest
        .deleteService(id)
        .then((service) => _callBackDelete.onDeleteServiceSuccess(service))
        .catchError((onError) => _callBackDelete.onDeleteServiceError(onError.toString()));
  }
}