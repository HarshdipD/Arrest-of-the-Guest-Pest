import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

void main() => runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        home: myState()
    )
);

class myState extends StatefulWidget {
  @override
  _myStateState createState() => _myStateState();
}

class _myStateState extends State<myState> {

  String status = "Unlocked";
  bool value1 = false;

  Widget get head
  {
    return Container(
      decoration: BoxDecoration(border: new Border.all(color: Colors.black), color: Colors.grey),
      width: 20.0,
      height: 20.0,
    );
  }

  //Widget that contains text and switch
  Widget get changeStatus
  {
    return Column(
      children: <Widget>[
        head,
        new Container(
            child: Text("Lock/unlock your car", style: TextStyle(fontSize: 20.0, color: Colors.green)),
          decoration: new BoxDecoration(
            border: new Border.all(color: Colors.red),
          ),
        ),
        switchStatus,
        Text(status),
      ],
    );
  }

  //Switch widget
  Widget get switchStatus
  {
    return new Switch(value: value1, onChanged: (value)=> change());
  }
  change(){
    setState(() {
      if(value1 == false)
        {
          status = "Locked";
        }
      else
        {
          status = "Unlocked";
        }
      value1 =! value1;
    });
  }

  //Settings
  Widget get settings
  {
    return IconButton(icon: Icon(Icons.settings), onPressed: bb());
  }

  bb()
  {
    print("hello");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Arrest the Pest Guest!")),
        backgroundColor: Colors.red,
        elevation: 0.0,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              width: 1000.0,
              height: 220.0,
              child: Container(
                color: Colors.black54,
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: CircleAvatar(
                          radius: 45.0,
                          backgroundImage: AssetImage('images/image1.jpeg'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child:
                      Text("Hey User",
                        style: TextStyle(color: Colors.white, fontSize: 17.0, fontFamily: "packages/cool_fonts/Roboto"),),
                    ),
                  ],
                ),
              ),
            ),
            changeStatus,
            settings,
          ],
        ),
      ),
    );
  }
}