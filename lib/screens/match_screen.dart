import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:criket/buttons/input_button.dart';
import 'package:criket/screens/home_screen.dart';
import 'result_screen.dart';
import 'package:provider/provider.dart';
import 'package:criket/app_state.dart';
import 'dart:math';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';

final oversBowl = [
  '0.0', '0.1', '0.2', '0.3', '0.4', '0.5', '1.0', '1.1', '1.2', '1.3', '1.4', '1.5', '2.0', '2.1', '2.2', '2.3', '2.4', '2.5', '3.0', '3.1', '3.2', '3.3', '3.4', '3.5', '4.0', '4.1', '4.2', '4.3', '4.4', '4.5', '5.0', '5.1', '5.2', '5.3', '5.4', '5.5', '6.0', '6.1', '6.2', '6.3', '6.4', '6.5', '7.0', '7.1', '7.2', '7.3', '7.4', '7.5', '8.0', '8.1', '8.2', '8.3', '8.4', '8.5', '9.0', '9.1', '9.2', '9.3', '9.4', '9.5','10.0'
];

final currentInputImage = [
  'images/zero.svg', 'images/one.svg', 'images/two.svg', 'images/three.svg', 'images/four.svg', 'images/five.svg', 'images/six.svg'
];

final batOrBowl = ['images/cricket_bat.png', 'images/cricket_ball.png'];

class MatchScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MatchScreenState();
  }
}

class MatchScreenState extends State<MatchScreen> with TickerProviderStateMixin {
  late Animation<double> userAnimation, cpuAnimation, inputAnimation, inputFadeAnimation;
  late AnimationController userAnimationController, cpuAnimationController, inputAnimationController, inputFadeAnimationController;
  bool isInputVisible = false;

  @override
  void initState() {
    super.initState();
    userAnimationController = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    userAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(userAnimationController);
    cpuAnimationController = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    cpuAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(cpuAnimationController);
    inputAnimationController = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    inputAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(inputAnimationController);
    inputFadeAnimationController = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    inputFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(inputFadeAnimationController);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width / 2;
    final screenHeight = MediaQuery.of(context).size.height - 90;
    final appState = Provider.of<AppState>(context);return WillPopScope(
      onWillPop: () async {
        Fluttertoast.showToast(
          msg: "You cannot go back now",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                height: 90,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 50.0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'YOU',
                                  style: TextStyle(
                                      color: appState.getYouRedColor,
                                      fontSize: 18),
                                ),
                                Image.asset(
                                    batOrBowl[appState.getUserPlayImage],
                                    width: 40,
                                    height: 30)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 50.0),
                            child: Row(
                              children: <Widget>[
                                Text('CPU',
                                    style: TextStyle(
                                        color: Color.fromRGBO(
                                            57, 57, 57, 0.28),
                                        fontSize: 18)),
                                Image.asset(
                                    batOrBowl[appState.getCpuPlayImage],
                                    width: 40,
                                    height: 30)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: appState.getShadowColor,
                        blurRadius: 20,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
              ),
              Row(
                children: <Widget>[
                  Container(decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(
                              width: 2,
                              color: Color.fromRGBO(0, 0, 0, 0.06)))),
                      width: screenWidth,
                      height: screenHeight,
                      child: displayMatch(
                          context,
                          this,
                          userAnimation,
                          userAnimationController,
                          -1.0,
                          appState.getUserOvers.toString(),
                          appState.getUserScore.toString(),
                          appState.getCurrentUserInput,
                          appState.getIsInputVisible,
                          appState.getYouRedColor,
                          appState.getScoreLightGray,
                          Color.fromRGBO(221, 63, 63, 100),
                          appState.getIsMatchStart)),
                  Container(
                      width: screenWidth,
                      height: screenHeight,
                      child: displayMatch(
                          context,
                          this,
                          cpuAnimation,
                          cpuAnimationController,
                          1.0,
                          appState.getCpuOvers.toString(),
                          appState.getCpuScore.toString(),
                          appState.getCurrentCpuInput,
                          appState.getIsInputVisible,
                          appState.getCpuGrayColor,
                          appState.getScoreLightGray,
                          Color.fromRGBO(119, 119, 119, 100),
                          appState.getIsMatchStart))
                ],
              )
            ],
          ),
          inputSelectionContainer(
              context,
              this,
              appState.getInputContainerStart,
              appState.getInputContainerEnd,
              inputAnimation,
              inputAnimationController)
        ]),
      ),
    );
  }
}

Widget inputSelection(String input, context) {
  final appState = Provider.of<AppState>(context);
  bool firstBattingCompleted = appState.getFirstBattingCompleted;
  return Material(
      type: MaterialType.transparency,
      child: InkWell(
      onTap: () {
    appState.setIsInputVisible(true);
    appState.setCurrentUserInput(int.parse(input));
    appState.setInputContainerStart(0.0);
    appState.setInputContainerEnd(1.0);
    appState.setYouRedColor(Color.fromRGBO(221, 63, 6, 100));
    appState.setCpuGrayColor(Color.fromRGBO(57, 57, 57, 0.28));
    appState.setShadowColor(Color.fromRGBO(221, 63, 63, 0.24));
    appState.setScoreLightGray(Color.fromRGBO(0, 0, 0, 0.28));
    appState.setIsMatchStart(true);
    if (firstBattingCompleted) {
      secondBatting(context, int.parse(input));
    } else {
      firstBatting(context, int.parse(input));
    }
      },
        borderRadius: BorderRadius.circular(50),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            input,
            style: TextStyle(
                color: Colors.white, fontSize:28, fontWeight: FontWeight.bold),
          ),
        ),
      ));
}

void firstBatting(context, userInput) {
  final appState = Provider.of<AppState>(context, listen: false);
  int userOrCpu = appState.getBattingOrBowling;
  int totalBalls = appState.getTotalOvers;
  int userScore = appState.getUserScore;
  int ballsCompleted = appState.getBallsCompleted;
  int cpuInputScore = cpuInput();
  appState.setCurrentCpuInput(cpuInputScore);
  Future.delayed(Duration(seconds: 2), () {
    if (userOrCpu == 0) {
      appState.setUserPlayImage(0);
      appState.setCpuPlayImage(1);
      if (ballsCompleted < totalBalls - 1) {
        if (userInput != cpuInputScore) {
          appState.setUserScore(ballsCompleted+ 1.toInt());
          appState.setBallsCompleted(ballsCompleted + 1.toInt());
          appState.setUserOvers(oversBowl[ballsCompleted + 1]);
        } else if (userInput == cpuInputScore) {
          appState.setFirstBattingCompleted(true);
          appState.setBallsCompleted(0);
          appState.setUserOvers(oversBowl[ballsCompleted + 1]);
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (_) => AlertDialog(
                title: Center(
                  child: Text(
                    "That's a Wicket",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('You are out. You have to bowl now.'),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromRGBO(221, 63, 63, 0.8),
                            ),
                            onPressed: () {
                              appState.setUserPlayImage(1);
                              appState.setCpuPlayImage(0);
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Bowl now',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromRGBO(221, 63, 63, 0.8),
                            ),
                            onPressed: () {
                              appState.setCpuScore(0);
                              appState.setUserScore(0);
                              appState.setFirstBattingCompleted(false);
                              appState.setCpuOvers('0.0');
                              appState.setUserOvers('0.0');
                              appState.setBallsCompleted(0);
                              appState.setCurrentCpuInput(0);
                              appState.setCurrentUserInput(0);
                              appState.setGetBack(false);
                              appState.setIsMatchStart(false);
                              Navigator.push(
                                  context,CupertinoPageRoute(
                                  builder: (context) => HomeScreen()));
                            },
                            child: Text(
                              'Exit Match',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ));
        }
      } else if (ballsCompleted == totalBalls - 1) {
        appState.setUserScore(ballsCompleted+ 1.toInt());
        appState.setUserOvers(oversBowl[ballsCompleted + 1]);
        appState.setFirstBattingCompleted(true);
        appState.setBallsCompleted(0);
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (_) => AlertDialog(
              title: Center(
                child: Text("End of innings",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold)),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Your Batting is over. You have to bowl now.'),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromRGBO(221, 63, 63, 0.8),
                              ),
                              onPressed: () {
                                appState.setUserPlayImage(1);
                                appState.setCpuPlayImage(0);
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Bowl now',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromRGBO(221, 63, 63, 0.8),
                              ),
                              onPressed: () {
                                appState.setCpuScore(0);
                                appState.setUserScore(0);
                                appState.setFirstBattingCompleted(false);
                                appState.setCpuOvers('0.0');
                                appState.setUserOvers('0.0');
                                appState.setBallsCompleted(0);
                                appState.setCurrentCpuInput(0);
                                appState.setCurrentUserInput(0);
                                appState.setGetBack(false);
                                appState.setIsMatchStart(false);
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            HomeScreen()));
                              },
                              child: Text(
                                'Exit Match',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ));
      }
    } else {
      appState.setUserPlayImage(0);
      appState.setCpuPlayImage(1);
      if (ballsCompleted < totalBalls - 1) {
        if (userInput != cpuInputScore) {
          appState.setUserScore(ballsCompleted+ 1.toInt());
          appState.setBallsCompleted(ballsCompleted + 1.toInt());
          appState.setUserOvers(oversBowl[ballsCompleted + 1]);
        } else if (userInput == cpuInputScore) {
          appState.setFirstBattingCompleted(true);
          appState.setBallsCompleted(0);
          appState.setUserOvers(oversBowl[ballsCompleted + 1]);
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (_) => AlertDialog(
              title: Center(
                child: Text(
                  "That's a Wicket",
                  style: TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
              content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                  Text('You are out. You have to bowl now.'),
              Padding(
              padding: const EdgeInsets.only(top: 16.0),
  child: Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: <Widget>[ElevatedButton(
  style: ElevatedButton.styleFrom(
  backgroundColor: Color.fromRGBO(221, 63,63,0.8),
  ),
    onPressed: () {
      appState.setUserPlayImage(1);
      appState.setCpuPlayImage(0);
      Navigator.pop(context);
    },
    child: Text(
      'Bowl now',style: TextStyle(color: Colors.white),
    ),
  ),
    ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromRGBO(221, 63, 63, 0.8),
      ),
      onPressed: () {
        appState.setCpuScore(0);
        appState.setUserScore(0);
        appState.setFirstBattingCompleted(false);
        appState.setCpuOvers('0.0');
        appState.setUserOvers('0.0');
        appState.setBallsCompleted(0);
        appState.setCurrentCpuInput(0);
        appState.setCurrentUserInput(0);
        appState.setGetBack(false);
        appState.setIsMatchStart(false);
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => HomeScreen()));
      },
      child: Text(
        'Exit Match',
        style: TextStyle(color: Colors.white),
      ),
    ),
  ],
  ),
              )
                  ],
              ),
              ));
        }
      } else if (ballsCompleted == totalBalls - 1) {
        appState.setUserScore(ballsCompleted+ 1.toInt());
        appState.setUserOvers(oversBowl[ballsCompleted + 1]);
        appState.setFirstBattingCompleted(true);
        appState.setBallsCompleted(0);
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (_) => AlertDialog(
              title: Center(child: Text("End of innings",
                  style: TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold)),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Your Batting is over. You have to bowl now.'),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromRGBO(221, 63, 63, 0.8),
                              ),
                              onPressed: () {
                                appState.setUserPlayImage(1);
                                appState.setCpuPlayImage(0);
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Bowl now',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromRGBO(221, 63, 63, 0.8),
                              ),
                              onPressed: () {
                                appState.setCpuScore(0);
                                appState.setUserScore(0);
                                appState.setFirstBattingCompleted(false);
                                appState.setCpuOvers('0.0');
                                appState.setUserOvers('0.0');
                                appState.setBallsCompleted(0);
                                appState.setCurrentCpuInput(0);
                                appState.setCurrentUserInput(0);
                                appState.setGetBack(false);
                                appState.setIsMatchStart(false);
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            HomeScreen()));
                              },
                              child: Text(
                                'Exit Match',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ));
      }
    }
  });
}

void secondBatting(context, userInput) {
  final appState = Provider.of<AppState>(context, listen: false);
  int userOrCpu = appState.getBattingOrBowling;
  int totalBalls = appState.getTotalOvers;
  int cpuScore = appState.getCpuScore;
  int userScore = appState.getUserScore;
  int ballsCompleted = appState.getBallsCompleted;
  int cpuInputScore = cpuInput();
  appState.setCurrentCpuInput(cpuInputScore);
  Future.delayed(Duration(seconds: 2), () {
    if (userOrCpu == 0) {
      appState.setUserPlayImage(0);
      appState.setCpuPlayImage(1);
      if (ballsCompleted < totalBalls - 1) {
        if (userInput != cpuInputScore) {
          appState.setUserScore(ballsCompleted+ 1.toInt());
          appState.setBallsCompleted(ballsCompleted + 1.toInt());
          appState.setUserOvers(oversBowl[ballsCompleted + 1]);
          if (appState.getUserScore > appState.getCpuScore) {
            Navigator.push(context,
                CupertinoPageRoute(builder: (context) => ResultPage()));
          }
        } else if (userInput == cpuInputScore) {
          Navigator.push(
              context, CupertinoPageRoute(builder: (context) => ResultPage()));
        }
      } else if (ballsCompleted == totalBalls - 1) {
        appState.setUserScore(ballsCompleted+ 1.toInt());
        appState.setUserOvers(oversBowl[ballsCompleted + 1]);
        Navigator.push(
            context, CupertinoPageRoute(builder: (context) => ResultPage()));
      }
    } else {
      appState.setUserPlayImage(1);
      appState.setCpuPlayImage(0);
      if (ballsCompleted < totalBalls - 1) {
        if (userInput != cpuInputScore) {
          appState.setCpuScore(cpuScore + cpuInputScore);
          appState.setBallsCompleted(ballsCompleted + 1.toInt());appState.setCpuOvers(oversBowl[ballsCompleted + 1]);
          if (appState.getCpuScore > appState.getUserScore) {
            Navigator.push(context,
                CupertinoPageRoute(builder: (context) => ResultPage()));
          }
        } else if (userInput == cpuInputScore) {
          appState.setBallsCompleted(0);
          appState.setCpuOvers(oversBowl[ballsCompleted + 1]);
          Navigator.push(
              context, CupertinoPageRoute(builder: (context) => ResultPage()));
        }
      } else if (ballsCompleted == totalBalls - 1) {
        appState.setCpuScore(cpuScore + cpuInputScore);
        appState.setCpuOvers(oversBowl[ballsCompleted + 1]);
        appState.setBallsCompleted(ballsCompleted + 1.toInt());
        Navigator.push(
            context, CupertinoPageRoute(builder: (context) => ResultPage()));
      }
    }
  });
}

int cpuInput() {
  int min = 0;
  int max = 7;
  final rdm = new Random();
  int rnd = min + rdm.nextInt(max - min);
  return rnd;
}

Widget displayMatch(
    context,
    vsync,
    user,
    userController,
    start,
    oversCompleted,
    runsScored,
    currentInput,
    isVisible,
    youColor,
    overTextColor,
    iconColor,
    isMatchStarted) {
  userController =
      AnimationController(duration: Duration(seconds: 1), vsync: vsync);

  user = Tween(begin: start, end: 0.0).animate(
      CurvedAnimation(parent: userController, curve: Curves.fastOutSlowIn));

  userController.forward();

  late AnimationController inputFadeAnimationController;
  late Animation<double> inputFadeAnimation;

  inputFadeAnimationController =
      AnimationController(duration: Duration(seconds: 1), vsync: vsync);
  inputFadeAnimation =
      Tween(begin: 1.0, end: 0.0).animate(inputFadeAnimationController);

  inputFadeAnimationController.forward();final width = MediaQuery.of(context).size.width;
  return Column(
      children: <Widget>[
      Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 32.0),
            child: Text(
              oversCompleted,
              style: TextStyle(
                  color: overTextColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32.0),
            child: Text(
              runsScored,
              style: TextStyle(
                  color: youColor,
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
        Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: AnimatedBuilder(
            animation: userController,
            builder: (context, child) {
              return Transform(
                transform:
                Matrix4.translationValues(user.value * width, 0.0, 0.0),
                child: isMatchStarted
                    ? FadeTransition(
                  opacity: inputFadeAnimation,
                  child: SvgPicture.asset(
                    currentInputImage[currentInput],
                    width: 100,
                    height: 100,
                    color: iconColor,
                  ),
                )
                    : Container(),
              );
            },
          ),
        )
      ],
  );
}

Widget inputSelectionContainer(context, vsync, start, end, input,
    inputAnimationController) {
  inputAnimationController =
      AnimationController(duration: Duration(seconds: 1), vsync: vsync);

  input = Tween(begin: start, end: end).animate(CurvedAnimation(
      parent: inputAnimationController, curve: Curves.fastOutSlowIn));

  inputAnimationController.forward();
  return AnimatedBuilder(
    animation: inputAnimationController,
    builder: (context, child) {
      return Align(alignment: Alignment.bottomCenter,
        child: FractionalTranslation(
          translation: Offset(0.0, input.value),
          child: Container(
            height: 350,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.16),
                    blurRadius: 20,
                  ),
                ],
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                color: Colors.white),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 32.0),
                      child: inputSelection('0', context),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 32.0),
                      child: inputSelection('1', context),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 32.0),
                      child: inputSelection('2', context),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 32.0),
                      child: inputSelection('3', context),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 32.0),
                      child: inputSelection('4', context),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 32.0),
                      child: inputSelection('5', context),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 32.0),
                      child: inputSelection('6', context),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}