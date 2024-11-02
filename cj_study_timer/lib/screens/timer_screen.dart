import 'package:flutter/material.dart';
import 'dart:async';
import '/widgets/timer_display.dart';
import '/widgets/start_button.dart';
import '/widgets/menu_button.dart';
import '/widgets/slider_widget.dart';
import '/widgets/sliding_menu.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen>
    with TickerProviderStateMixin {
  double _sliderValue = 10;
  int _timeInSeconds = 600;
  Timer? _timer;
  bool _isRunning = false;
  bool _showMenu = false;
  late int _initialTimeInSeconds;
  late AnimationController _animationController;
  late AnimationController _menuController;

  @override
  void initState() {
    super.initState();
    _initialTimeInSeconds = _timeInSeconds;
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _menuController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
  }

  void _toggleMenu() {
    setState(() {
      _showMenu = !_showMenu;
      if (_showMenu) {
        _menuController.forward(); // Slide menu in
      } else {
        _menuController.reverse(); // Slide menu out
      }
    });
  }

  void _startTimer() {
    if (_isRunning) {
      _cancelTimer();
      return;
    }
    setState(() {
      _isRunning = true;
      _animationController.forward();
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeInSeconds > 0) {
        setState(() => _timeInSeconds--);
      } else {
        _timer?.cancel();
        setState(() {
          _isRunning = false;
          _animationController.reverse();
        });
      }
    });
  }

  void _cancelTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _timeInSeconds = _initialTimeInSeconds;
      _animationController.reverse();
    });
  }

  String get _formattedTime {
    final minutes = (_timeInSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_timeInSeconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    _menuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff81d8d0),
      body: Stack(
        children: [
          MenuButton(
            showMenu: _showMenu,
            menuController: _menuController,
            toggleMenu: _toggleMenu,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TimerDisplay(formattedTime: _formattedTime),
                const SizedBox(height: 370),
                StartButton(
                  isRunning: _isRunning,
                  onPressed: _startTimer,
                ),
              ],
            ),
          ),
          SliderWidget(
            sliderValue: _sliderValue,
            animationController: _animationController,
            onChanged: _isRunning
                ? null
                : (newValue) {
                    setState(() {
                      _sliderValue = newValue;
                      _timeInSeconds = (_sliderValue * 60).toInt();
                      _initialTimeInSeconds = _timeInSeconds;
                    });
                  },
          ),
          if (_showMenu)
            SlidingMenu(
              menuController: _menuController,
              closeMenu: () => setState(() => _showMenu = false),
            ),
        ],
      ),
    );
  }
}
