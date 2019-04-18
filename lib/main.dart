import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:metamood_flutter/Mood.dart';
import 'package:metamood_flutter/MoodBar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getVariables();

    location.onLocationChanged().listen((value) {
      setState(() {
        userLocation = value;
      });
    });
  }

  int _verySadCounter;
  int _sadCounter;
  int _happyCounter;
  int _veryHappyCounter;

  var location = new Location();

  Map<String, double> userLocation;

  void _incrementCounter(Mood moodType) {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to h
      switch (moodType) {
        case Mood.verySad:
          {
            _verySadCounter++;
            break;
          }
        case Mood.sad:
          {
            _sadCounter++;
            break;
          }
        case Mood.happy:
          {
            _happyCounter++;
            break;
          }
        case Mood.veryHappy:
          {
            _veryHappyCounter++;
            break;
          }
      }
    });

    _updateStore();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            userLocation == null
                ? CircularProgressIndicator()
                : Text(""),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('How are you feeling now?',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
            ),
            MoodBar(
              happyCounter: _happyCounter,
              veryHappyCounter: _veryHappyCounter,
              sadCounter: _sadCounter,
              verySadCounter: _verySadCounter,
              incrementCounter: _incrementCounter,
            ),
            Text('Your location:  ${userLocation["latitude"].toString()} ${userLocation["longitude"].toString()}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text('Date: ' + "${DateTime.now().year.toString()}-${DateTime.now().month.toString().padLeft(2,'0')}-${DateTime.now().day.toString().padLeft(2,'0')}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text('Weather: 🌤️',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            RaisedButton(
                color: Colors.green[900],
                child: Text('I want a fresh start.', style: TextStyle(fontSize: 15, color: Colors.white)),
                onPressed: () async {

                  this._sadCounter = 0;
                  this._happyCounter = 0;
                  this._veryHappyCounter = 0;
                  this._verySadCounter = 0;
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.clear();

                },
                splashColor: Colors.white),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(
              icon: Icon(Icons.business), title: Text('Business')),
          BottomNavigationBarItem(
              icon: Icon(Icons.school), title: Text('School')),
        ],
        currentIndex: 0,
        fixedColor: Colors.deepPurple,
        onTap: (i) {},
      )
      ,

    );
  }

  Future<Map<String, double>> _getLocation() async {
    var currentLocation = <String, double>{};
    try {
      currentLocation = (await location.getLocation()) as Map<String, double>;
    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }


  Future<void> _getVariables() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    this._verySadCounter = (prefs.getInt('_verySadCounter') ?? 0);
    this._veryHappyCounter = (prefs.getInt('_veryHappyCounter') ?? 0);
    this._happyCounter = (prefs.getInt('_happyCounter') ?? 0);
    this._sadCounter = (prefs.getInt('_sadCounter') ?? 0);

  }


  Future<void> _updateStore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setInt('_verySadCounter', _verySadCounter);
    await prefs.setInt('_veryHappyCounter', _veryHappyCounter);
    await prefs.setInt('_happyCounter', _happyCounter);
    await prefs.setInt('_sadCounter', _sadCounter);


    int counter = (prefs.getInt('counter') ?? 0) + 1;
    print('Pressed $counter times.');
    await prefs.setInt('counter', counter);
  }

}
