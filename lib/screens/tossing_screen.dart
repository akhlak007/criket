import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math';
import 'package:criket/app_state.dart';
import 'match_screen.dart'; // Adjust the path for your MatchScreen

class TossingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TossingPageState();
  }
}

class TossingPageState extends State<TossingPage> {
  bool isTossing = true;
  String tossResult = 'TOSSING';
  Color tossContainerColor = Color.fromRGBO(255, 255, 255, 0.5);
  String winner = "";
  Widget choice = Text('');
  late String youHaveTo;
  Widget batting = Container();
  Widget bowling = Container();
  late String opponentChoice;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Fluttertoast.showToast(
            msg: 'You cannot go back now',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);
        return false;
      },
      child: Scaffold(
        backgroundColor: Color.fromRGBO(221, 63, 63, 1),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 75),
              child: Stack(children: <Widget>[
                Center(
                  child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: isTossing
                          ? CircularProgressIndicator(
                        valueColor:
                        AlwaysStoppedAnimation(Colors.white),
                        strokeWidth: 5.0,
                      )
                          : null,
                    ),
                    height: 220,
                    width: 220,
                  ),
                ),
                Center(
                  child: Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(110),
                        border:
                        Border.all(color: tossContainerColor, width: 5)),
                  ),
                ),
                Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 90.0),
                      child: Text(
                        tossResult,
                        style: TextStyle(fontSize: 36, color: tossContainerColor),
                      ),
                    ))
              ]),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    winner,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                choice,
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                    child: batting,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 40.0),
                    child: bowling,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isTossing = false;
        tossResult = tossResultfun(context);
        tossContainerColor = Colors.white;

        if (toss(context)) {
          winner = "You won the toss.";
          choice = Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'What would you like to do?',
              style: TextStyle(
                  fontSize: 20, color: Color.fromRGBO(255, 255, 255, 0.5)),
            ),
          );

          batting = InkWell(
            onTap: () {
              setPlayImage(context, 0, 1);
              selectBattingOrBowling(1, context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MatchScreen()));
            },
            child: buttons('T', 'Batting', Color.fromRGBO(255, 255, 255, 0.5),
                Color.fromRGBO(229, 109, 109, 100), Colors.white, Colors.white),
            borderRadius: BorderRadius.circular(20),
          );

          bowling = InkWell(
            onTap: () {
              setPlayImage(context, 1, 0);
              selectBattingOrBowling(0, context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MatchScreen()));
            },
            child: buttons('B', 'Bowling', Color.fromRGBO(255, 255, 255, 0.5),
                Color.fromRGBO(229, 109, 109, 100), Colors.white, Colors.white),
            borderRadius: BorderRadius.circular(20),
          );
        } else {
          int selection = opponentSelection();
          if (selection == 0) {
            setPlayImage(context, 1, 0);
            opponentChoice = 'Batting';
            youHaveTo = 'Bowler';
          } else {
            setPlayImage(context, 0, 1);
            opponentChoice = 'Bowling';
            youHaveTo = 'Batsman';
          }
          winner = "You lose the toss.";
          choice = Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Opponent Selected ',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                Text(opponentChoice,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold))
              ],
            ),
          );

          batting = Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You will play as ',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              Text(youHaveTo,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold))
            ],
          );

          bowling = InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                selectBattingOrBowling(selection, context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MatchScreen()));
              },
              child: gotItButton());
        }
      });
    });
  }
}

bool toss(BuildContext context) {
  final appState = Provider.of<AppState>(context);
  int total = appState.selectedInput; // Directly access the getter
  int input = appState.oddOrEven; // Directly access the getter
  int result = total % 2;
  return input == result;
}

String tossResultfun(BuildContext context) {
  final appState = Provider.of<AppState>(context);
  return appState.selectedInput % 2 == 0 ? 'EVEN' : 'ODD';
}

int opponentSelection() {
  int min = 0;
  int max = 2;
  final rdm = Random();
  return min + rdm.nextInt(max - min);
}

void selectBattingOrBowling(int selection, BuildContext context) {
  final appState = Provider.of<AppState>(context, listen: false);
  appState.setBattingOrBowling(selection);
}

void setPlayImage(BuildContext context, int user, int cpu) {
  final appState = Provider.of<AppState>(context, listen: false);
  appState.setUserPlayImage(user);
  appState.setCpuPlayImage(cpu);
}

Widget buttons(String label, String text, Color backgroundColor, Color borderColor, Color textColor, Color disabledTextColor) {
  return Container(
    decoration: BoxDecoration(
      color: backgroundColor,
      border: Border.all(color: borderColor),
      borderRadius: BorderRadius.circular(20),
    ),
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(color: textColor, fontSize: 24),
        ),
        SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(color: textColor, fontSize: 20),
        ),
      ],
    ),
  );
}

Widget gotItButton() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
    ),
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    child: Text(
      'Got it!',
      style: TextStyle(color: Colors.red, fontSize: 20),
    ),
  );
}
