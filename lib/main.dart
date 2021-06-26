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
  var positionSarary = [20000, 10000, 7000, 5000, 3000];
  var positionName = ['役員クラス', 'マネージャークラス', '部長クラス', '主任クラス', '一般社員クラス'];
  var positionValue = ['0', '0', '0', '0', '0'];
  int sumSalary = 0;

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), _countUp);
    changeButton();
  }

  void _countUp(Timer timer) {
    setState(() {
      counter++;
    });
    seconds = counter;
    if (counter >= 60) {
      seconds = seconds % 60;
      minutes = (counter / 60).floor();
    }
    if (minutes >= 60) {
      minutes = minutes % 60;
      hours = (minutes / 60).floor();
    }
    sumSalary = 0;
    for (int i = 0; i < positionSarary.length; i++) {
      sumSalary += counter *
          int.parse(positionValue[i]) *
          (positionSarary[i] / 3600).round();
    }
  }

  void stopTimer() {
    timer.cancel();
    changeButton();
  }

  void finishTimer() {
    timer.cancel();
    setState(() {
      counter = 0;
      seconds = 0;
      minutes = 0;
      hours = 0;
      sumSalary = 0;
    });
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            for (var i = 0; i < positionValue.length; i++)
              Container(
                decoration: BoxDecoration(
                  // 枠線
                  border: Border.all(color: Colors.black, width: 1),
                  // 角丸
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 280,
                      child: Text(
                        positionName[i] + ' ' + positionValue[i] + '人',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    DropdownButton<String>(
                      // value: dropdownValue,
                      icon: const Icon(Icons.arrow_drop_down_sharp),
                      iconSize: 40,
                      elevation: 16,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          positionValue[i] = newValue;
                        });
                      },
                      items: <String>['0', '1', '2', '3', '4', '5', '6', '7']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
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
                              ))),
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
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
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 150,
                      height: 150,
                      child: RaisedButton(
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(75),
                        ),
                        onPressed: () async {
                          // ダイアログを表示------------------------------------
                          finishTimer();
                          var result = await showDialog<int>(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('確認'),
                                content: Text('確認のダイアログです。'),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text('Cancel'),
                                    onPressed: () =>
                                        Navigator.of(context).pop(0),
                                  ),
                                  FlatButton(
                                    child: Text('OK'),
                                    onPressed: () =>
                                        Navigator.of(context).pop(1),
                                  ),
                                ],
                              );
                            },
                          );
                          print('dialog result: $result');
                          // --
                        },
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
