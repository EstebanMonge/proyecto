import 'package:flutter/material.dart';
import 'package:login/models/service.dart';
import 'package:login/services/response/service_response.dart';

class ServicePage extends StatefulWidget {
  @override
  _ServicePageState createState() => new _ServicePageState();
}

class _ServicePageState extends State<ServicePage> implements CreateServiceCallBack,GetServiceCallBack,DeleteServiceCallBack {
  BuildContext _ctx;
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  String _name;

  CreateServiceResponse _responseCreate;
  GetServiceResponse _responseGet;
  DeleteServiceResponse _responseDelete;
  List<Service> listService;

  _ServicePageState() {
    _responseCreate = new CreateServiceResponse(this);
    _responseGet = new GetServiceResponse(this);
    _responseDelete = new DeleteServiceResponse(this);
    listService = new List<Service>();
    _responseGet.doGet();
  }

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        _responseCreate.doCreate(_name);
      });
    }
  }

  void _delete(int id) {
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() {
        _isLoading = true;
        _responseDelete.doDelete(id);
      });
    }
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }

  SingleChildScrollView dataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: [
          DataColumn(label: Text('Id')),
          DataColumn(label: Text('Nombre')),
          DataColumn(label: Text('Acción')),
        ],
        rows:
        listService // Loops through dataColumnText, each iteration assigning the value to element
            .map(
          ((element) => DataRow(
            cells: <DataCell>[
              DataCell(Text(element.id.toString())), //Extracting from Map element the value
              DataCell(Text(element.name)),
              DataCell( new IconButton(
                icon: const Icon(Icons.delete_forever,
                    color: const Color(0xFF167F67)),
                onPressed: () => _delete(element.id),
                alignment: Alignment.centerLeft,
              )),
            ],
          )),
        )
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;

    var loginBtn = new RaisedButton(
      onPressed: _submit,
      child: new Text("Guardar"),
      color: Colors.green,
    );
    var serviceForm = new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Form(
          key: formKey,
          child: new Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  onSaved: (val) => _name = val,
                  decoration: new InputDecoration(labelText: "Nombre"),
                ),
              )
            ],
          ),
        ),
        loginBtn
      ],
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Servicios"),
      ),
      key: scaffoldKey,
      body: new Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
          serviceForm,
          Expanded(
            child : dataBody(),
          ),
        ],
      ),
    );
  }

  @override
  void onCreateServiceError(String error) {
    // TODO: implement onLoginError
    _showSnackBar(error);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onCreateServiceSuccess(int service) async {

    if(service > 0){
      // TODO: implement onLoginSuccess
      _responseGet.doGet();
      _showSnackBar("Registro guardado satisfactoriamente");
      setState(() {
        _isLoading = false;
      });
    }else{
      // TODO: implement onLoginSuccess
      _showSnackBar("Falló, por favor revisar");
      setState(() {
        _isLoading = false;
      });
    }

  }

  @override
  void onGetServiceError(String error) {
    // TODO: implement onLoginError
    _showSnackBar(error);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onGetServiceSuccess(List<Service> service) async {

    if(service != null){
      // TODO: implement onLoginSuccess
      listService = service;
      setState(() {});
    }else{
    }

  }

  @override
  void onDeleteServiceError(String error) {
    // TODO: implement onLoginError
    _showSnackBar(error);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onDeleteServiceSuccess(int service) async {

    if(service > 0){
      _responseGet.doGet();
      // TODO: implement onLoginSuccess
      _showSnackBar("Registro eliminado satisfactoriamente");
      setState(() {
        _isLoading = false;
      });
    }else{
      // TODO: implement onLoginSuccess
      _showSnackBar("Falló, por favor revisar");
      setState(() {
        _isLoading = false;
      });
    }

  }
}