import 'package:criket/screens/tossing_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:criket/app_state.dart';

class TossSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context); // Access AppState

    return Scaffold(
      appBar: AppBar(
        title: Text('Toss Selection'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Choose a number between 0 and 6:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(7, (index) {
                return ElevatedButton(
                  onPressed: () {
                    appState.setSelectedInput(index); // Set the user's selected input
                  },
                  child: Text('$index'),
                );
              }),
            ),
            SizedBox(height: 20),
            Text(
              'Choose Odd or Even:',
              style: TextStyle(fontSize: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    appState.setOddOrEven(1); // 1 for Odd
                  },
                  child: Text('Odd'),
                ),
                ElevatedButton(
                  onPressed: () {
                    appState.setOddOrEven(0); // 0 for Even
                  },
                  child: Text('Even'),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                appState.generateCpuTossInput(); // Generate CPU random input

                // Check toss result
                bool userWinsToss = appState.checkTossResult();

                String tossResultMessage;
                if (userWinsToss) {
                  tossResultMessage = 'You won the toss!';
                } else {
                  tossResultMessage = 'CPU won the toss!';
                }

                // Show the toss result in a dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Toss Result'),
                      content: Text(tossResultMessage),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context); // Close the dialog
                            // Navigate to the TossingScreen
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => TossingPage()),
                            );
                          },
                          child: Text('Continue'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Confirm Toss'),
            ),
          ],
        ),
      ),
    );
  }
}
