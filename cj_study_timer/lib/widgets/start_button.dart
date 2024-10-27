import 'package:flutter/material.dart';

class StartButton extends StatelessWidget {
  final bool isRunning;
  final VoidCallback onPressed;

  const StartButton(
      {required this.isRunning, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isRunning ? const Color(0xFFEF9A9A) : Colors.white,
          foregroundColor: isRunning ? Colors.white : Colors.black,
          side: const BorderSide(color: Colors.grey, width: 2.0),
          shadowColor: Colors.black,
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          isRunning ? "Cancel" : "Start",
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
