import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/timer_screen.dart';

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
