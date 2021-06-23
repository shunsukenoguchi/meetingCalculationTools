import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '会議費用計算ツール'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int counter = 0;
  Timer timer;
  bool switchBool = true;
  int seconds = 0;
  int minutes = 0;
  int hours = 0;
  int sumSalary = 0;
  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), _countUp);
    changeButton();
  }

  void _countUp(Timer timer) {
    setState(() {
      counter++;
    });
  }

  void stopTimer() {
    timer.cancel();
    changeButton();
  }

  void finishTimer() {
    timer.cancel();
    counter = 0;
    if (switchBool == false) {
      changeButton();
    }
  }

  void changeButton() {
    setState(() {
      switchBool = !switchBool;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '$sumSalary円',
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '$hours時間$minutes分$seconds秒',
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (switchBool)
                    SizedBox(
                        width: 150,
                        height: 150,
                        child: RaisedButton(
                            color: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(75),
                            ),
                            onPressed: startTimer,
                            child: Text(
                              '会議開始',
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )))
                  else
                    SizedBox(
                      width: 150,
                      height: 150,
                      child: RaisedButton(
                        color: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(75),
                        ),
                        onPressed: stopTimer,
                        child: Text(
                          '会議中断',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: RaisedButton(
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(75),
                      ),
                      onPressed: finishTimer,
                      child: Text(
                        '終了',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
