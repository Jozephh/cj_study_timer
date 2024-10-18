import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';

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
        textTheme: GoogleFonts.robotoTextTheme(),
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

class _TimerScreenState extends State<TimerScreen>
    with TickerProviderStateMixin {
  double _sliderValue = 10; // Default to 10 minutes
  int _timeInSeconds = 600; // 10 minutes in seconds
  Timer? _timer;
  bool _isRunning = false;
  late int _initialTimeInSeconds;
  bool _showMenu = false; // Menu visibility state
  late AnimationController _animationController; // Animation for slider
  late AnimationController _menuController; // Animation for menu slide

  @override
  void initState() {
    super.initState();
    _initialTimeInSeconds = _timeInSeconds;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _menuController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400), // Menu slide duration
    );
  }

  void _startTimer() {
    if (_isRunning) {
      _cancelTimer();
      return;
    }
    setState(() {
      _isRunning = true;
      _animationController.forward(); // Start the slider animation
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
          _animationController.reverse(); // Bring the slider back when done
        });
      }
    });
  }

  void _cancelTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _timeInSeconds = _initialTimeInSeconds;
      _animationController.reverse(); // Bring the slider back when canceled
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
      backgroundColor: Colors.grey, // Grey background
      body: Stack(
        children: [
          // Menu Button (Square-shaped with bigger, bolder lines)
          Positioned(
            top: 40,
            left: 20,
            child: SizedBox(
              width: 80, // Menu button size
              height: 80,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Square shape
                  ),
                  backgroundColor: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _showMenu = !_showMenu;
                    if (_showMenu) {
                      _menuController.forward(); // Slide menu in
                    } else {
                      _menuController.reverse(); // Slide menu out
                    }
                  });
                },
                // Custom lines for the menu button
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: 24,
                      child: Container(
                        width: 40,
                        height: 6,
                        color: Colors.black,
                      ),
                    ),
                    Positioned(
                      top: 38,
                      child: Container(
                        width: 40,
                        height: 6,
                        color: Colors.black,
                      ),
                    ),
                    Positioned(
                      top: 52,
                      child: Container(
                        width: 40,
                        height: 6,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
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
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                      fontSize: 100, // Much larger timer font
                      fontWeight: FontWeight.w100, // Thin style for timer
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                    height: 370), // Added space between timer and button
                SizedBox(
                  width: 160, // Proportional size for the start button
                  height: 60,
                  child: ElevatedButton(
                    onPressed: _startTimer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isRunning
                          ? const Color(
                              0xFFEF9A9A) // Soft pastel red when running
                          : Colors.white,
                      foregroundColor: _isRunning ? Colors.white : Colors.black,
                      side: const BorderSide(
                          color: Colors.grey, width: 2.0), // Light grey border
                      shadowColor: Colors.black, // Shading for the button
                      elevation: 6, // Add depth to the button
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8), // Rounded corners
                      ),
                    ),
                    child: Text(
                      _isRunning ? "Cancel" : "Start",
                      style: const TextStyle(
                          fontSize: 24), // Larger font in button
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Slider on the right side
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Positioned(
                top: 200, // Align to middle of the start button
                right: 20 - (_animationController.value * 200), // Slide in/out
                bottom: 165, // Align to middle of the timer
                child: RotatedBox(
                  quarterTurns: 3,
                  child: Opacity(
                    opacity: 1 - _animationController.value, // Fades out
                    child: Slider(
                      value: _sliderValue,
                      min: 10, // Start at 10 minutes
                      max: 120, // Max 2 hours (120 minutes)
                      divisions: 22, // 5-minute increments
                      label: "${_sliderValue.toInt()} minutes",
                      onChanged: _isRunning
                          ? null // Disable while timer is running
                          : (newValue) {
                              setState(() {
                                _sliderValue = newValue;
                                _timeInSeconds = (_sliderValue * 60).toInt();
                                _initialTimeInSeconds = _timeInSeconds;
                              });
                            },
                      activeColor: Colors.white,
                      inactiveColor: Colors.grey,
                    ),
                  ),
                ),
              );
            },
          ),
          // Menu (Sliding to open)
          if (_showMenu)
            SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-1, 0), // Start from left
                end: Offset.zero, // Slide in to normal position
              ).animate(_menuController),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomRight,
                          colors: [Colors.white, Colors.grey],
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 100),
                          _menuButton("Button 1"),
                          _menuButton("Store"),
                          _menuButton("Achievements"),
                        ],
                      ),
                    ),
                  ),
                  // Right darkened side, clicking closes the menu
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _showMenu = false;
                          _menuController.reverse(); // Slide menu out
                        });
                      },
                      child: Container(
                        color: Colors.black
                            .withOpacity(0.5), // Darkened right half
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _menuButton(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: ElevatedButton(
        onPressed: () {
          // Add actions for buttons here
        },
        child: Text(text),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    _menuController.dispose(); // Dispose menu controller
    super.dispose();
  }
}
