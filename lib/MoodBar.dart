import 'package:flutter/material.dart';
import 'package:metamood_flutter/Mood.dart';

class MoodBar extends StatelessWidget {
  MoodBar({
    @required this.incrementCounter,
    @required this.verySadCounter,
    @required this.sadCounter,
    @required this.happyCounter,
    @required this.veryHappyCounter,
  });

  final Function incrementCounter;
  final int verySadCounter;
  final int sadCounter;
  final int happyCounter;
  final int veryHappyCounter;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          children: <Widget>[
            ClipOval(
              child: Container(
                color: Colors.green,
                child: FlatButton(
                    child: Text('😄', style: TextStyle(fontSize: 40)),
                    onPressed: () {
                      incrementCounter(Mood.veryHappy);
                    },
                    splashColor: Colors.white),
              ),
            ),
            Text(
              '$veryHappyCounter',
              style: Theme.of(context).textTheme.display1,
            )
          ],
        ),
        Column(
          children: <Widget>[
            ClipOval(
              child: Container(
                color: Colors.lightGreen,
                child: FlatButton(
                    child: Text('🙂', style: TextStyle(fontSize: 40)),
                    onPressed: () {
                      incrementCounter(Mood.happy);
                    },
                    splashColor: Colors.white),
              ),
            ),
            Text(
              '$happyCounter',
              style: Theme.of(context).textTheme.display1,
            )
          ],
        ),
        Column(
          children: <Widget>[
            ClipOval(
              child: Container(
                color: Colors.orange,
                child: FlatButton(
                    child: Text('😔', style: TextStyle(fontSize: 40)),
                    onPressed: () {
                      incrementCounter(Mood.sad);
                    },
                    splashColor: Colors.white),
              ),
            ),
            Text(
              '$sadCounter',
              style: Theme.of(context).textTheme.display1,
            )
          ],
        ),
        Column(
          children: <Widget>[
            ClipOval(
              child: Container(
                color: Colors.red,
                child: FlatButton(
                    child: Text('😩', style: TextStyle(fontSize: 40)),
                    onPressed: () {
                      incrementCounter(Mood.verySad);
                    },
                    splashColor: Colors.white),
              ),
            ),
            Text(
              '$verySadCounter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ],
    );
  }
}
