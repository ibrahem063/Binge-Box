import 'package:bingebox/constants/cubit/cubit.dart';
import 'package:bingebox/constants/cubit/states.dart';
import 'package:bingebox/constants/slider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvSeriesScreen extends StatelessWidget {
  const TvSeriesScreen({super.key});

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
              sliderList(cubit.popularseries, 'popular tv series', cubit.popularseries.length),
              sliderList(cubit.ontheair, 'on the air', cubit.ontheair.length),
              sliderList(cubit.toprated, 'top rated series', cubit.toprated.length),
            ],
          );
        }
      },
    );
  }
}

