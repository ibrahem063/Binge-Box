import 'package:bingebox/constants/cubit/cubit.dart';
import 'package:bingebox/constants/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvSeriesScreen extends StatelessWidget {
  const TvSeriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = bingeboxCubit.get(context);
    return BlocConsumer<bingeboxCubit, bingeboxStates>(
      listener: (BuildContext context, bingeboxStates state) {},
      builder: (BuildContext context, bingeboxStates state) {
        if (state is RelodedSeriesDoneState) {
          return  FutureBuilder(
            builder: (context, snapshot) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(left: 10,top: 15, bottom: 40),
                    child: Text('popular tv series',style: TextStyle(color: Colors.white)),
                  ),
                  SizedBox(
                    height: 250,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount:cubit.serires.length ,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {

                          },
                          child: Container(
                            width: 170,
                            margin: const EdgeInsets.only(left: 13),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        'https://image.tmdb.org/t/p/w500${cubit.serires[index]['poster_path']}'
                                    )
                                )
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
            future: cubit.Serieslisthome() as Future,
          );
        } else if (state is RelodedSeriesErrorState) {
          return const Center(child: Text("Failed to load trending movies"));
        } else {
          return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ));
        }
      },
    );
  }
}
