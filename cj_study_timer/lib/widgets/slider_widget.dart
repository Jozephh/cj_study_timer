import 'package:flutter/material.dart';
import '../models/timer_model.dart';

class SliderWidget extends StatelessWidget {
  final TimerModel timerModel;

  const SliderWidget({super.key, required this.timerModel});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: timerModel.animationController,
      builder: (context, child) {
        return Positioned(
          right: 20 - (timerModel.animationController.value * 200),
          child: RotatedBox(
            quarterTurns: 3,
            child: Opacity(
              opacity: 1 - timerModel.animationController.value,
              child: Slider(
                value: timerModel.sliderValue,
                min: 10,
                max: 120,
                divisions: 22,
                onChanged: (newValue) {
                  timerModel.sliderValue = newValue;
                  timerModel.timeInSeconds = (newValue * 60).toInt();
                  timerModel.initialTimeInSeconds = timerModel.timeInSeconds;
                  timerModel.notifyListeners();
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
