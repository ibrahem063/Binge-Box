import 'package:bingebox/constants/color.dart';
import 'package:flutter/material.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(child: Text('Movies',style: TextStyle(color: Colors.white),)),
    );
  }
}
