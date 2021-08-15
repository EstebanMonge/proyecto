import 'package:flutter/material.dart';
import 'package:login/models/user.dart';
import 'package:login/services/response/user_response.dart';
import 'package:date_time_picker/date_time_picker.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => new _UserPageState();
}

class _UserPageState extends State<UserPage> implements CreateUserCallBack,GetUserCallBack,DeleteUserCallBack {
  BuildContext _ctx;
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  String _username, _password, _name, _lastname, _surname, _phone, _email;
  int _birthdate;

  CreateUserResponse _responseCreate;
  GetUserResponse _responseGet;
  DeleteUserResponse _responseDelete;
  List<User> listUser;

  _UserPageState() {
    _responseCreate = new CreateUserResponse(this);
    _responseGet = new GetUserResponse(this);
    _responseDelete = new DeleteUserResponse(this);
    listUser = new List<User>(); 
    _responseGet.doGet();
  }

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        _responseCreate.doCreate(_username, _password, _name, _lastname, _surname, _phone, _email, _birthdate);
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
          DataColumn(label: Text('Contraseña')),
          DataColumn(label: Text('Acción')),
        ],
        rows:
            listUser // Loops through dataColumnText, each iteration assigning the value to element
                .map(
                  ((element) => DataRow(
                        cells: <DataCell>[
                          DataCell(Text(element.id.toString())), //Extracting from Map element the value
                          DataCell(Text(element.username)),
                          DataCell(Text(element.password)),
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
    var cacaForm = new Container(
      child: new Row (
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [new Column (

        ),]
      )
    );
    var userForm = new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Form(
          key: formKey,
          child: new Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(5.0),
                child: new TextFormField(
                  onSaved: (val) => _username = val,
                  decoration: new InputDecoration(labelText: "Usuario"),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(5.0),
                child: new TextFormField(
                  onSaved: (val) => _password = val,
                  decoration: new InputDecoration(labelText: "Contraseña"),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(5.0),
                child: new TextFormField(
                  onSaved: (val) => _name = val,
                  decoration: new InputDecoration(labelText: "Nombre"),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(5.0),
                child: new TextFormField(
                  onSaved: (val) => _lastname = val,
                  decoration: new InputDecoration(labelText: "Apellido 1"),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(5.0),
                child: new TextFormField(
                  onSaved: (val) => _surname = val,
                  decoration: new InputDecoration(labelText: "Apellido 2"),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(5.0),
                child: new TextFormField(
                  onSaved: (val) => _email = val,
                  decoration: new InputDecoration(labelText: "Correo electrónico"),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(5.0),
                child: new TextFormField(
                  onSaved: (val) => _phone = val,
                  decoration: new InputDecoration(labelText: "Teléfono"),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(5.0),
                child: new DateTimePicker(
                  initialValue: '',
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                  dateMask: 'd MMM, yyyy',
                  dateLabelText: 'Fecha de nacimiento',
                  onChanged: (val) => print(val),
                  validator: (val) {
                    print(val);
                    return null;
                  },
                  //onSaved: (val) => _birthdate = DateTime.fromMillisecondsSinceEpoch(val),
                  onSaved: (val) => _birthdate = DateTime.parse(val).millisecondsSinceEpoch,
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
        title: new Text("Usuarios"),
      ),
      key: scaffoldKey,
      body: new Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            userForm,
            Expanded(
              child : dataBody(),
            ),
          ],
        ),
    );
  }

  @override
  void onCreateUserError(String error) {
    // TODO: implement onLoginError
    _showSnackBar(error);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onCreateUserSuccess(int user) async {    

    if(user > 0){
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
  void onGetUserError(String error) {
    // TODO: implement onLoginError
    _showSnackBar(error);
    setState(() {
      _isLoading = false;
    });
  }

   @override
  void onGetUserSuccess(List<User> user) async {    

    if(user != null){
      // TODO: implement onLoginSuccess
      listUser = user;
      setState(() {});
    }else{
    }
    
  }

  @override
  void onDeleteUserError(String error) {
    // TODO: implement onLoginError
    _showSnackBar(error);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onDeleteUserSuccess(int user) async {    

    if(user > 0){
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