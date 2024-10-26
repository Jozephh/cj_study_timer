import 'package:flutter/material.dart';
import '../widgets/menu_button.dart';
import '../widgets/start_button.dart';
import '../widgets/slider_widget.dart';
import '../models/timer_model.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen>
    with TickerProviderStateMixin {
  final TimerModel _timerModel = TimerModel();

  @override
  void initState() {
    super.initState();
    _timerModel.initControllers(this);
  }

  @override
  void dispose() {
    _timerModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Stack(
        children: [
          MenuButton(timerModel: _timerModel),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _timerModel.formattedTime,
                  style: const TextStyle(
                    fontSize: 100,
                    fontWeight: FontWeight.w100,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 370),
                StartButton(timerModel: _timerModel),
              ],
            ),
          ),
          SliderWidget(timerModel: _timerModel),
          _buildMenu(),
        ],
      ),
    );
  }

  Widget _buildMenu() {
    if (_timerModel.showMenu) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-1, 0),
          end: Offset.zero,
        ).animate(_timerModel.menuController),
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
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _timerModel.showMenu = false;
                    _timerModel.menuController.reverse();
                  });
                },
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(); // Fallback widget
    }
  }

  Widget _menuButton(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: ElevatedButton(
        onPressed: () {
          // Define action for each menu button
        },
        child: Text(text),
      ),
    );
  }
}
