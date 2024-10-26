import 'dart:async';
import 'package:flutter/material.dart';

class TimerModel extends ChangeNotifier {
  bool showMenu = false;
  bool isRunning = false;
  late AnimationController menuController;
  late AnimationController animationController;
  double sliderValue = 10; // Default to 10 minutes
  int timeInSeconds = 600; // Default time in seconds (10 minutes)
  late int initialTimeInSeconds;
  Timer? _timer;

  void initControllers(TickerProvider vsync) {
    // Initialize menuController with a duration
    menuController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 400),
    );

    // Initialize animationController for slider animations
    animationController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 600),
    );

    initialTimeInSeconds = timeInSeconds;
  }

  String get formattedTime {
    final minutes = (timeInSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (timeInSeconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  void toggleMenu() {
    showMenu = !showMenu;
    showMenu ? menuController.forward() : menuController.reverse();
    notifyListeners();
  }

  void startTimer() {
    if (isRunning) {
      // Stop the timer if it's already running
      _timer?.cancel();
      isRunning = false;
      timeInSeconds = initialTimeInSeconds; // Reset time
      animationController.reverse(); // Reverse any animation if needed
    } else {
      // Start the timer if it's not running
      isRunning = true;
      animationController.forward(); // Start any animation if needed

      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (timeInSeconds > 0) {
          timeInSeconds--;
          notifyListeners();
        } else {
          // Timer is complete
          _timer?.cancel();
          isRunning = false;
          animationController
              .reverse(); // Reverse animation when timer finishes
          notifyListeners();
        }
      });
    }
    notifyListeners(); // Notify listeners of the state change
  }

  @override
  void dispose() {
    _timer?.cancel();
    menuController.dispose();
    animationController.dispose();
    super.dispose();
  }
}
