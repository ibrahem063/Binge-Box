
import 'package:flutter/material.dart';

import 'movie_details_screen.dart';
import 'series_details_screen.dart';

class CheckerScreen extends StatelessWidget {
  final int newid;
  final String newtype;

  const CheckerScreen(
  this.newid,
  this.newtype,
      {super.key,});

  @override
  Widget build(BuildContext context) {
    if(newtype=='movie'){
      return MovieDetailsScreen(movieId: newid,);
    }
    else if(newtype=='Tv'){
      return SeriesDetailsScreen(id: newid);
    }
    else{
      return const Scaffold(
        body: Center(
          child: Text('Error'),
        ),
      );
    }
  }
}
