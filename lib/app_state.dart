import 'package:flutter/material.dart';
import 'dart:math';

class AppState extends ChangeNotifier {
  int _selectedInput = 0; // User's selected input for the toss
  int _oddOrEven = 1; // 1 for odd, 0 for even
  int _cpuTossInput = 0; // CPU's random input for the toss

  // User and CPU game state variables
  int totalOvers = 0;
  int battingOrBowling = 0;
  int cpuScore = 0;
  int userScore = 0;
  int ballsCompleted = 0;
  bool firstBattingCompleted = false;
  bool getBack = true;
  String cpuOvers = '0.0';
  String userOvers = '0.0';
  int currentUserInput = 0;
  int currentCpuInput = 0;
  bool isInputVisible = false;
  double inputContainerStart = 1.0;
  double inputContainerEnd = 0.0;
  Color youRedColor = Color.fromRGBO(221, 63, 63, 100);
  Color cpuGrayColor = Color.fromRGBO(119, 119, 119, 100);
  Color scoreLightGray = Color.fromRGBO(168, 168, 168, 100);
  Color shadowColor = Color.fromRGBO(255, 150, 150, 0.6);
  bool isMatchStart = false;

  int _playerImage = 0; // Image for the player
  int _opponentImage = 0; // Image for the opponent

  int userPlayImage = 0;
  int cpuPlayImage = 0;

  // Function to set user's selected input for the toss
  void setSelectedInput(int input) {
    _selectedInput = input;
    notifyListeners(); // Notify UI of changes
  }

  // Function to set whether the user chose odd or even
  void setOddOrEven(int choice) {
    _oddOrEven = choice; // 1 for odd, 0 for even
    notifyListeners();
  }

  // Function to generate CPU's random input for the toss
  void generateCpuTossInput() {
    Random random = Random();
    _cpuTossInput = random.nextInt(7); // CPU selects a number between 0 and 6
    notifyListeners();
  }

  // Function to check if the toss result matches the player's choice
  bool checkTossResult() {
    int sum = _selectedInput + _cpuTossInput; // Sum of user and CPU inputs
    return (sum % 2 == _oddOrEven);
  }

  // Additional game functions
  void setTotalOvers(int text) {
    totalOvers = text;
    notifyListeners();
  }

  void setBattingOrBowling(int text) {
    battingOrBowling = text;
    notifyListeners();
  }

  void setUserScore(int text) {
    userScore = text;
    notifyListeners();
  }

  void setCpuScore(int text) {
    cpuScore = text;
    notifyListeners();
  }

  void setBallsCompleted(int text) {
    ballsCompleted = text;
    notifyListeners();
  }

  void setFirstBattingCompleted(bool text) {
    firstBattingCompleted = text;
    notifyListeners();
  }

  void setCpuOvers(String text) {
    cpuOvers = text;
    notifyListeners();
  }

  void setUserOvers(String text) {
    userOvers = text;
    notifyListeners();
  }

  void setCurrentUserInput(int text) {
    currentUserInput = text;
    notifyListeners();
  }

  void setCurrentCpuInput(int text) {
    currentCpuInput = text;
    notifyListeners();
  }

  void setGetBack(bool text) {
    getBack = text;
    notifyListeners();
  }

  void setIsInputVisible(bool text) {
    isInputVisible = text;
    notifyListeners();
  }

  void setInputContainerStart(double text) {
    inputContainerStart = text;
    notifyListeners();
  }

  void setInputContainerEnd(double text) {
    inputContainerEnd = text;
    notifyListeners();
  }

  void setYouRedColor(Color text) {
    youRedColor = text;
    notifyListeners();
  }

  void setCpuGrayColor(Color text) {
    cpuGrayColor = text;
    notifyListeners();
  }

  void setScoreLightGray(Color text) {
    scoreLightGray = text;
    notifyListeners();
  }

  void setShadowColor(Color text) {
    shadowColor = text;
    notifyListeners();
  }

  void setIsMatchStart(bool text) {
    isMatchStart = text;
    notifyListeners();
  }

  void setUserPlayImage(int text) {
    userPlayImage = text;
    notifyListeners();
  }

  void setCpuPlayImage(int text) {
    cpuPlayImage = text;
    notifyListeners();
  }

  // Getters for state variables
  int get selectedInput => _selectedInput;
  int get oddOrEven => _oddOrEven;
  int get cpuTossInput => _cpuTossInput;
  int get playerImage => _playerImage;
  int get opponentImage => _opponentImage;
  int get getTotalOvers => totalOvers;
  int get getBattingOrBowling => battingOrBowling;
  int get getUserScore => userScore;
  int get getCpuScore => cpuScore;
  int get getBallsCompleted => ballsCompleted;
  bool get getFirstBattingCompleted => firstBattingCompleted;
  String get getCpuOvers => cpuOvers;
  String get getUserOvers => userOvers;
  int get getCurrentUserInput => currentUserInput;
  int get getCurrentCpuInput => currentCpuInput;
  bool get getGetBack => getBack;
  bool get getIsInputVisible => isInputVisible;
  double get getInputContainerStart => inputContainerStart;
  double get getInputContainerEnd => inputContainerEnd;
  Color get getYouRedColor => youRedColor;
  Color get getCpuGrayColor => cpuGrayColor;
  Color get getScoreLightGray => scoreLightGray;
  Color get getShadowColor => shadowColor;
  bool get getIsMatchStart => isMatchStart;
  int get getUserPlayImage => userPlayImage;
  int get getCpuPlayImage => cpuPlayImage;
}
