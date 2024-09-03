import 'package:bingebox/constants/cubit/cubit.dart';
import 'package:bingebox/constants/cubit/states.dart';
import 'package:bingebox/constants/slider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = bingeboxCubit.get(context);
    return BlocConsumer<bingeboxCubit, bingeboxStates>(
      listener: (BuildContext context, bingeboxStates state) {
        if (state is SeriesErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error')),
          );
        }
      },
      builder: (BuildContext context, bingeboxStates state) {
        if(state is SeriesLoadingState)
        {
          return const Center(child: CircularProgressIndicator(color: Colors.red,));
        }
        else{
          return Column(
            children: [
              sliderList(cubit.popularmovies, 'popular movies', cubit.popularmovies.length),
              sliderList(cubit.nowmovies, 'now playing', cubit.nowmovies.length),
              sliderList(cubit.topratedmovies, 'top rated movies', cubit.topratedmovies.length),
            ],
          );
        }
      },
    );
  }
}

