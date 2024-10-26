import 'package:flutter/material.dart';
import '../models/timer_model.dart';

class StartButton extends StatelessWidget {
  final TimerModel timerModel;

  const StartButton({super.key, required this.timerModel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 60,
      child: ElevatedButton(
        onPressed: timerModel.startTimer,
        child: Text(timerModel.isRunning ? "Cancel" : "Start"),
      ),
    );
  }
}
