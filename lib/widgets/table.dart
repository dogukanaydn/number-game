import 'dart:async';

import 'package:flutter/material.dart';

class TablePart extends StatefulWidget {
  TablePart({Key key}) : super(key: key);

  @override
  _TablePartState createState() => _TablePartState();
}

class _TablePartState extends State<TablePart> {
  List<int> arrList;
  List<int> shuffledList;

  int arrListLength = 25;
  int temp = 1;
  List<bool> colorControl;
  bool gameControl = false;

  _TablePartState() {
    arrList = List.generate(arrListLength, (index) => index + 1);
    colorControl = List.generate(arrListLength, (index) => false);

    shuffledList = arrList.toList();
    shuffledList.shuffle();
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void tableBtnPressed(int number) {
    if (number == temp) {
      setState(() {
        colorControl[temp - 1] = true;
        if (number == arrListLength) {
          setState(() {
            gameControl = true;
          });
        }
      });
      temp++;
    }
  }

  int startTime = 0;
  Timer _timer;
  int score;
  int bestScore = 0;

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (temp <= arrListLength) {
          startTime++;
        }
        if (gameControl == true) {
          score = startTime;
          convertScore(score);

          if (bestScore == 0) {
            bestScore = score;
          }
          if (score < bestScore) {
            bestScore = score;
            convertScore(score);
          }
          _timer.cancel();
        }
      });
    });
  }

  void replay() {
    setState(() {
      startTime = 0;
      gameControl = false;
      temp = 1;
      colorControl = List.generate(arrListLength, (index) => false);
      shuffledList.shuffle();
    });

    startTimer();
  }

  int perMinutes = 0;
  int perSecond = 0;

  Widget convertScore(int value) {
    if (value == null) {
      value = perSecond;
    } else if (value >= 60) {
      perMinutes = (value ~/ 60).toInt();
      value = (value % 60);
      return Text('Best Score: ${perMinutes > 0 ? perMinutes : '00'}:$value ');
    } else {
      return Text('Best Score: 00:$value');
    }
    return Text('Best Score: 0');
  }

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Column(
        children: [
          convertScore(score),
          Text('Time Elapsed: $startTime'),
          Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
            width: 300,
            height: 300,
            child: GridView.count(
              crossAxisCount: 5,
              crossAxisSpacing: 3,
              mainAxisSpacing: 3,
              children: shuffledList
                  .map(
                    (index) => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: colorControl[index - 1]
                            ? Colors.green
                            : Colors.blue,
                        textStyle: TextStyle(color: Colors.white),
                      ),
                      onPressed:
                          gameControl ? null : () => tableBtnPressed(index),
                      child: Text('$index'),
                    ),
                  )
                  .toList(),
            ),
          ),
          Visibility(
            visible: temp == arrListLength + 1,
            child: ElevatedButton(
              child: Text('Replay'),
              onPressed: replay,
            ),
          ),
        ],
      ),
    );
  }
}
