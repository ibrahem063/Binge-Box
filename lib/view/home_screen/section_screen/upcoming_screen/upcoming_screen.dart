import 'package:bingebox/constants/color.dart';
import 'package:flutter/material.dart';

class UpcomingScreen extends StatelessWidget {
  const UpcomingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(child: Text('Upcoming', style: TextStyle(color: Colors.white),)),
    );
  }
}
