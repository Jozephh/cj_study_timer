import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimerDisplay extends StatelessWidget {
  final String formattedTime;

  const TimerDisplay({required this.formattedTime, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      formattedTime,
      style: GoogleFonts.roboto(
        textStyle: const TextStyle(
          fontSize: 100,
          fontWeight: FontWeight.w100,
          color: Colors.white,
        ),
      ),
    );
  }
}
