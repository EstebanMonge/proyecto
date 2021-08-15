import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:login/screen/user_page.dart';
import 'package:login/screen/service_page.dart';
import 'package:login/screen/appointment_page.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback signOut;
  HomeScreen(this.signOut);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  signOut() {
   setState(() {
     widget.signOut();
   });
 }

 var value;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");
    });
  }

  @override
 void initState() {
   // TODO: implement initState
   super.initState();
   getPref();
 }


   @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Proyecto SO"),
        actions: <Widget>[
           IconButton(
             onPressed: () {
               signOut();
             },
             icon: Icon(Icons.lock_open),
           )
         ],
      ),
      body: new Center(
          child: Column(children: <Widget>[
            Container(
              margin: EdgeInsets.all(25),
              child: FlatButton(
                child: Text(
                  'Crear usuario',
                  style: TextStyle(fontSize: 20.0),
                ),
                color: Colors.cyan,
                textColor: Colors.black,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserPage()),
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(25),
              child: FlatButton(
                child: Text(
                  'Crear servicio',
                  style: TextStyle(fontSize: 20.0),
                ),
                color: Colors.cyan,
                textColor: Colors.black,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ServicePage()),
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(25),
              child: FlatButton(
                child: Text(
                  'Crear cita',
                  style: TextStyle(fontSize: 20.0),
                ),
                color: Colors.cyan,
                textColor: Colors.black,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AppointmentPage()),
                  );
                },
              ),
            ),
          ])),
        //child: new Text("Citas"),
      //),
    );
  }
}