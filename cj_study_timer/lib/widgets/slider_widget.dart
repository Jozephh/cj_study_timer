import 'package:flutter/material.dart';

class SliderWidget extends StatelessWidget {
  final double sliderValue;
  final AnimationController animationController;
  final ValueChanged<double>? onChanged;

  const SliderWidget({
    required this.sliderValue,
    required this.animationController,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Positioned(
          top: 200,
          right: 20 - (animationController.value * 200),
          bottom: 165,
          child: RotatedBox(
            quarterTurns: 3,
            child: Slider(
              value: sliderValue,
              min: 10,
              max: 120,
              divisions: 22,
              label: "${sliderValue.toInt()} minutes",
              onChanged: onChanged,
              activeColor: Colors.white,
              inactiveColor: Colors.grey,
            ),
          ),
        );
      },
    );
  }
}
