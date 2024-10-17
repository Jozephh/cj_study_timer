import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minimal Timer',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.robotoTextTheme(), // Apply Roboto Font
      ),
      home: const TimerScreen(),
    );
  }
}

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  double _sliderValue = 25; // Default 25 minutes
  int _timeInSeconds = 1500; // 25 minutes in seconds
  Timer? _timer;
  bool _isRunning = false;
  late int _initialTimeInSeconds; // To store initial time for reset

  @override
  void initState() {
    super.initState();
    _initialTimeInSeconds = _timeInSeconds; // Initialize initial time
  }

  void _startTimer() {
    if (_isRunning) {
      _cancelTimer(); // Cancel the timer when the button is pressed again
      return;
    }
    setState(() {
      _isRunning = true;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeInSeconds > 0) {
        setState(() {
          _timeInSeconds--;
        });
      } else {
        _timer?.cancel();
        setState(() {
          _isRunning = false;
        });
      }
    });
  }

  void _cancelTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _timeInSeconds = _initialTimeInSeconds; // Reset timer to initial value
    });
  }

  String get _formattedTime {
    final minutes = (_timeInSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_timeInSeconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Menu Button
          Positioned(
            top: 40,
            left: 20,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.menu, color: Colors.black),
                onPressed: () {
                  // Menu button action
                },
              ),
            ),
          ),
          // Timer in the center
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _formattedTime,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 60, // Increased font size for timer
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _startTimer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isRunning
                        ? const Color(
                            0xFFEF9A9A) // Soft pastel red when running
                        : Colors.white,
                    foregroundColor: _isRunning
                        ? Colors.white // White text when running
                        : Colors.black,
                    side: _isRunning
                        ? const BorderSide(
                            color: Color(0xFFF48FB1), // Light red border
                            width: 2.0,
                          )
                        : null, // No border when idle
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    _isRunning
                        ? "Cancel"
                        : "Start", // Change text based on state
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          // Slider on the right side
          Positioned(
            top: 100,
            right: 20,
            bottom: 100,
            child: RotatedBox(
              quarterTurns: 3,
              child: Slider(
                value: _sliderValue,
                min: 5,
                max: 60,
                divisions: 11,
                label: "${_sliderValue.toInt()} minutes",
                onChanged: (newValue) {
                  setState(() {
                    _sliderValue = newValue;
                    _timeInSeconds =
                        (_sliderValue * 60).toInt(); // Update timer in seconds
                    _initialTimeInSeconds =
                        _timeInSeconds; // Update initial time for reset
                  });
                },
                activeColor: Colors.white,
                inactiveColor: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
