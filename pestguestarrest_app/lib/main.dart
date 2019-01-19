import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  bool _value1 = false;
  bool _value2 = false;

  void _onChanged1(bool value) => setState(() => _value1 = value);
  void _onChanged2(bool value) => setState(() => _value2 = value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Pest Guest Arrest")),
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
            Padding(
              padding: const EdgeInsets.only(top: 160.0, bottom: 20.0),
              child: Text("Lock/Unlock object", style: TextStyle(color: Colors.red, fontSize: 20.0),),
            ),
            new Switch(value: _value1, onChanged: _onChanged1),
          ],
        ),
      ),
    );
  }

}