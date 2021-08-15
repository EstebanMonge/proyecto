import 'package:flutter/material.dart';
import 'package:login/models/appointment.dart';
import 'package:login/services/response/appointment_response.dart';
import 'package:date_time_picker/date_time_picker.dart';

class AppointmentPage extends StatefulWidget {
  @override
  _AppointmentPageState createState() => new _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> implements CreateAppointmentCallBack,GetAppointmentCallBack,DeleteAppointmentCallBack {
  BuildContext _ctx;
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  String _user_id, _service_id;
  int _date;

  CreateAppointmentResponse _responseCreate;
  GetAppointmentResponse _responseGet;
  DeleteAppointmentResponse _responseDelete;
  List<Appointment> listAppointment;

  _AppointmentPageState() {
    _responseCreate = new CreateAppointmentResponse(this);
    _responseGet = new GetAppointmentResponse(this);
    _responseDelete = new DeleteAppointmentResponse(this);
    listAppointment = new List<Appointment>();
    _responseGet.doGet();
  }

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        _responseCreate.doCreate(_user_id, _service_id, _date);
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
          DataColumn(label: Text('Usuario')),
          DataColumn(label: Text('Servicio')),
          DataColumn(label: Text('Acción')),
        ],
        rows:
        listAppointment // Loops through dataColumnText, each iteration assigning the value to element
            .map(
          ((element) => DataRow(
            cells: <DataCell>[
              DataCell(Text(element.id.toString())), //Extracting from Map element the value
              DataCell(Text(element.user_id)),
              DataCell(Text(element.service_id)),
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
    String dropdownValue = 'One';

    var loginBtn = new RaisedButton(
      onPressed: _submit,
      child: new Text("Guardar"),
      color: Colors.green,
    );
    var appointmentForm = new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Form(
          key: formKey,
          child: new Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  onSaved: (val) => _user_id = val,
                  decoration: new InputDecoration(labelText: "Usuario"),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  onSaved: (val) => _service_id = val,
                  decoration: new InputDecoration(labelText: "Servicio"),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(5.0),
                child: new DateTimePicker(
                  initialValue: '',
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  dateMask: 'd MMM, yyyy',
                  dateLabelText: 'Fecha de cita',
                  onChanged: (val) => print(val),
                  validator: (val) {
                    print(val);
                    return null;
                  },
                  //onSaved: (val) => _birthdate = DateTime.fromMillisecondsSinceEpoch(val),
                  onSaved: (val) => _date = DateTime.parse(val).millisecondsSinceEpoch,
                ),
              ),
              UserWidget(),
            ],
          ),
        ),
        loginBtn
      ],
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Usuarios"),
      ),
      key: scaffoldKey,
      body: new Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
          appointmentForm,
          Expanded(
            child : dataBody(),
          ),
        ],
      ),
    );
  }

  @override
  void onCreateAppointmentError(String error) {
    // TODO: implement onLoginError
    _showSnackBar(error);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onCreateAppointmentSuccess(int appointment) async {

    if(appointment > 0){
      // TODO: implement onLoginSuccess
      _responseGet.doGet();
      _showSnackBar("Registro guardado de manera satisfactoria");
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
  void onGetAppointmentError(String error) {
    // TODO: implement onLoginError
    _showSnackBar(error);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onGetAppointmentSuccess(List<Appointment> appointment) async {

    if(appointment != null){
      // TODO: implement onLoginSuccess
      listAppointment = appointment;
      setState(() {});
    }else{
    }

  }

  @override
  void onDeleteAppointmentError(String error) {
    // TODO: implement onLoginError
    _showSnackBar(error);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onDeleteAppointmentSuccess(int appointment) async {

    if(appointment > 0){
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
/// This is the stateful widget that the main application instantiates.
class UserWidget extends StatefulWidget {
  const UserWidget({Key key}) : super(key: key);

  @override
  State<UserWidget> createState() => _UserWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _UserWidgetState extends State<UserWidget> {
  String dropdownValue = 'One';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>['One', 'Two', 'Free', 'Four']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}