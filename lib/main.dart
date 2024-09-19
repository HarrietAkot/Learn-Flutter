import 'package:flutter/material.dart';
import 'dart:async'; // To handle timer functionality

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Tap Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int score = 0; // Keeps track of the score
  bool isGameActive = false; // Checks if the game is running
  Timer? timer; // Timer object to track the game duration
  int timeLeft = 10; // Game duration in seconds

  // Function to start the game
  void startGame() {
    setState(() {
      score = 0; // Reset score
      isGameActive = true; // Start game
      timeLeft = 10; // Reset timer to 10 seconds
    });

    // Timer runs every second to update the time left
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (timeLeft > 0) {
          timeLeft--;
        } else {
          isGameActive = false; // Stop the game when time is over
          timer.cancel(); // Stop the timer
        }
      });
    });
  }

  // Function to increase score when screen is tapped
  void tapScreen() {
    if (isGameActive) {
      setState(() {
        score++;
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel(); // Cancel timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Tap Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display game status and timer
            Text(
              isGameActive ? 'Time Left: $timeLeft' : 'Tap to Start!',
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: 20),
            
            // Display current score
            Text(
              'Score: $score',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),

            // If the game is not active, display a start button
            if (!isGameActive)
              ElevatedButton(
                onPressed: startGame,
                child: Text('Start Game'),
              ),

            // If the game is active, make the whole screen tappable
            if (isGameActive)
              GestureDetector(
                onTap: tapScreen, // Increase score on tap
                child: Container(
                  color: Colors.transparent, // Transparent tappable area
                  width: double.infinity,
                  height: 300,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
