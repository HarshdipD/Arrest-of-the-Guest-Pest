import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'package:vibration/vibration.dart';

void main() => runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        home: myState(),
    ),
);


class myState extends StatefulWidget {
  @override
  _myStateState createState() => _myStateState();
}

class _myStateState extends State<myState> {
  Color color = Color.fromRGBO(198, 220, 255, 1);
  String status = "Unlocked";
  String car_name = "car";
  bool value1 = false;
  final dataref = FirebaseDatabase.instance.reference();

  @override
  void initState(){
    super.initState();
    Timer.periodic(const Duration(milliseconds:20), (Timer t) => triggerCall());
  }


  Widget get switchStatus {
    return new Switch(value: value1, onChanged: (value) => change());
  }
  Widget get settings {
    return IconButton(icon: Icon(Icons.settings,), iconSize: 30.0, onPressed: bb);
  }
  Widget get head {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Container(
          decoration: BoxDecoration(color: color, border: new Border.all(color: Colors.black), borderRadius: BorderRadius.all(Radius.circular(20.0))),
          width: 300.0,
          height: 300.0,
          child: Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Text("Lock/unlock your $car_name", style: TextStyle(fontSize: 20.0,)),
                    ),
                    switchStatus,
                    Text(status, style: TextStyle(fontSize: 20.0,),),
                  ],
                ),
              ],
            ),
          )
      ),
    );
  }
  Widget get header {
    return SafeArea(
        child: SizedBox(
          width: 1000.0,
          height: 180.0,
          child: Container(
            decoration: new BoxDecoration(
                color: Colors.black54,
            ),
            child: Column(
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: CircleAvatar(
                      radius: 45.0,
                      backgroundImage: AssetImage('assets/images/key.png'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text("Keeping your assets safe!", style: TextStyle(color: Colors.white, fontSize: 20.0),),
                )
              ],
            ),
          ),
        )
    );
  }
  change(){
    setState(() {
      if(value1 == false)
      {
        status = "Locked";
        runCode('1');

      }
      else
      {
        status = "Unlocked";
        runCode('0');
      }
      value1 =! value1;
      return;
    });
  }
  bb(){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: new Text("Change settings"),
            content: new Container(
              width: 260.0,
              height: 40.0,
              decoration: new BoxDecoration(
                shape: BoxShape.rectangle,
                color: const Color(0xFFFFFF),
                borderRadius:
                new BorderRadius.all(new Radius.circular(32.0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // dialog centre
                  new Expanded(
                    child: new Container(
                        child: new TextField(
                          decoration: new InputDecoration(
                            labelStyle: new TextStyle(color: Colors.green),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(3.0)),
                            ),
                            filled: true,
                            contentPadding: new EdgeInsets.only(
                                left: 10.0,
                                top: 10.0,
                                bottom: 10.0,
                                right: 10.0),
                            hintText: 'Change your car name from $car_name',
                            hintStyle: new TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 12.0,
                              fontFamily: 'helvetica_neue_light',
                            ),
                          ),
                          maxLength: 8,
                          autofocus: true,
                          onChanged: (String value){
                            print(car_name);
                            car_name = value;
                          },
                        )),
                    flex: 2,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                  child: Text("Change"),
                  onPressed: (){
                    setState(() {
                      Navigator.of(context, rootNavigator: true).pop();
                    });
                  })
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Arrest the guest pest!")),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            header,
            head,
            settings,
            RaisedButton(
              child: Text("Nevermind!"),
              onPressed: (){
                setState(() {
                  status = "Unlocked";
                  color = Color.fromRGBO(198, 220, 255, 1);
                  dataref.child("iot").update({
                    'trigger': '1'
                  });
                });
              },
            )
          ],
        ),
      ),
    );
  }

  void runCode(value){
    dataref.child("status").update({
      'toggle': value
    });
  }

  void triggerCall() async{
    dataref.child("iot").once().then((DataSnapshot snapshot){
      var a = snapshot.value['trigger'];
      if(a == '0')
        {
          //Trigger TO DO
          print(a);
          setState((){
              color = Color.fromRGBO(255, 71, 58, 1);
          });
        }
        else{
        vibratePhone();
        setState((){
          color = Color.fromRGBO(198, 220, 255, 1);
        });
      }
    });
  }

  Future<void> vibratePhone() async {
    Vibration.vibrate(pattern: [500, 1000, 500, 1000, 500, 1000, 500, 1000, 500, 1000, 500, 1000]);
  }

}
