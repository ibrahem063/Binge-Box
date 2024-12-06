import 'package:bingebox/constants/color.dart';
import 'package:bingebox/constants/cubit/cubit.dart';
import 'package:bingebox/view/watch_movies_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/review_uI.dart';
import '../../constants/trailer_uI.dart';
import '../../constants/cubit/states.dart';
import '../../constants/repttext.dart';
import '../../constants/slider_widget.dart';
import '../home_screen/home_screen.dart';

class MovieDetailsScreen extends StatelessWidget {
  final int movieId;

  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bingeboxCubit()..fetchMovieDetails(movieId),
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: BlocBuilder<bingeboxCubit, bingeboxStates>(
          builder: (context, state) {
            if (state is MovieDetailsLoading) {
              return const Center(
                  child: CircularProgressIndicator(color: Colors.red));
            } else if (state is MovieDetailsLoaded) {
              if (state.moviesGenres.isNotEmpty) {
                return CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverAppBar(
                          automaticallyImplyLeading: false,
                          leading: IconButton(
                              onPressed: () {
                                SystemChrome.setEnabledSystemUIMode(
                                    SystemUiMode.manual,
                                    overlays: [SystemUiOverlay.bottom]);
// SystemChrome.setEnabledSystemUIMode(
//     SystemUiMode.manual,
//     overlays: []);
                                SystemChrome.setPreferredOrientations([
                                  DeviceOrientation.portraitUp,
                                  DeviceOrientation.portraitDown,
                                ]);
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.arrow_back_ios_new),
                              iconSize: 28,
                              color: Colors.white),
                          actions: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          const HomeScreen()),
                                          (route) => false);
                                },
                                icon: const Icon(Icons.home_filled),
                                iconSize: 25,
                                color: Colors.white)
                          ],
                          backgroundColor: const Color.fromRGBO(18, 18, 18, 0.5),
                          centerTitle: false,
                          pinned: true,
                          expandedHeight:
                          MediaQuery.of(context).size.height * 0.4,
                          flexibleSpace: FlexibleSpaceBar(
                            collapseMode: CollapseMode.parallax,
                            background: FittedBox(
                              fit: BoxFit.fill,
                              child: TrailerWatch(
                                trailerytid:state.movieTrailersList.isNotEmpty
                                    ? state.movieTrailersList[0]['key']
                                    : '', // Se
                              ),
                            ),
                          )),
                      SliverList(
                          delegate: SliverChildListDelegate([
//add to favoriate button
// addtofavoriate(
//   id: widget.id,
//   type: 'movie',
//   Details: MovieDetails,
// ),

                            Column(
                              children: [
                                Row(children: [
                                  Container(
                                      padding:
                                      const EdgeInsets.only(left: 10, top: 10),
                                      height: 50,
                                      width: MediaQuery.of(context).size.width,
                                      child: ListView.builder(
                                          physics: const BouncingScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          itemCount: state.moviesGenres.length,
                                          itemBuilder: (context, index) {
//generes box
                                            return Container(
                                                margin:
                                                const EdgeInsets.only(right: 10),
                                                padding: const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    color: const Color.fromRGBO(
                                                        25, 25, 25, 1),
                                                    borderRadius:
                                                    BorderRadius.circular(10)),
                                                child: genrestext(
                                                    state.moviesGenres[index]));
                                          })),
                                ]),
                                Row(
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.all(10),
                                        margin:
                                        const EdgeInsets.only(left: 10, top: 10),
                                        height: 40,
                                        decoration: BoxDecoration(
                                            color:
                                            const Color.fromRGBO(25, 25, 25, 1),
                                            borderRadius: BorderRadius.circular(10)),
                                        child: genrestext(
                                            '${state.movieDetails[0]['runtime']} min'))
                                  ],
                                )
                              ],
                            ),
                            Padding(
                                padding: const EdgeInsets.only(left: 20, top: 10),
                                child: tittletext('Movie Story :')),
                            Padding(
                                padding: const EdgeInsets.only(left: 20, top: 10),
                                child: overviewtext(
                                    state.movieDetails[0]['overview'].toString())),
                            Padding(
                              padding: const EdgeInsets.only(left: 20, top: 10),
                              child: ReviewUI(revdeatils: state.userReviews),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(left: 20, top: 20),
                                child: normaltext(
                                    'Release Date : ${state.movieDetails[0]['release_date'].toString().substring(0, 4)}')),
                            Padding(
                                padding: const EdgeInsets.only(left: 20, top: 20),
                                child: normaltext(
                                    'Budget : ${state.movieDetails[0]['budget']}')),
                            Padding(
                                padding: const EdgeInsets.only(left: 20, top: 20),
                                child: normaltext(
                                    'Revenue : ${state.movieDetails[0]['revenue']}')),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => WatchMoviesNow(id: movieId),));
                              },
                              child: SizedBox(child: Text('WatchMoviesNow',style: TextStyle(color: Colors.red ,fontSize: 20),),),
                            ),
                            sliderList(state.similarMoviesList, "Similar Movies",
                                "movie", state.similarMoviesList.length),
                            sliderList(
                                state.recommendedMoviesList,
                                "Recommended Movies",
                                "movie",
                                state.recommendedMoviesList.length),
// Container(
//     height: 50,
//     child: Center(child: normaltext("By Niranjan Dahal")))
                          ]))
                    ]);
              } else {
                // إظهار رسالة أو شاشة بديلة في حال كانت القائمة فارغة
                return Center(child: Text('No results found'));
              }
            } else if (state is MovieDetailsError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return const Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }
}
