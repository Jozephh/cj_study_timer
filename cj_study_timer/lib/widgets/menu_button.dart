import 'package:flutter/material.dart';
import '../models/timer_model.dart';

class MenuButton extends StatelessWidget {
  final TimerModel timerModel;

  const MenuButton({super.key, required this.timerModel});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40,
      left: 20,
      child: SizedBox(
        width: 80,
        height: 80,
        child: ElevatedButton(
          onPressed: () {
            timerModel.toggleMenu(); // Toggle the menu using TimerModel
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: Colors.white,
          ),
          child: const Icon(Icons.menu, color: Colors.black),
        ),
      ),
    );
  }
}
