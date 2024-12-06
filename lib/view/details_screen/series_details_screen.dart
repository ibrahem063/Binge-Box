import 'package:bingebox/constants/color.dart';
import 'package:bingebox/constants/cubit/cubit.dart';
import 'package:bingebox/constants/width_and_height.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/review_uI.dart';
import '../../constants/trailer_uI.dart';
import '../../constants/cubit/states.dart';
import '../../constants/repttext.dart';
import '../../constants/slider_widget.dart';
import '../home_screen/home_screen.dart';

class SeriesDetailsScreen extends StatelessWidget {
  final int id;

  const SeriesDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    var cubit = bingeboxCubit.get(context);
    return BlocProvider(
      create: (context) => bingeboxCubit()
        ..fetchSeriesDetails(id), // <-- Change to fetchSeriesDetails
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: BlocBuilder<bingeboxCubit, bingeboxStates>(
          builder: (context, state) {
            if (state is SeriesDetailsLoading) {
              return const Center(
                  child: CircularProgressIndicator(color: Colors.red));
            } else if (state is SeriesDetailsLoaded) {
              if (state.SeriesGenres.isNotEmpty) {
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
                          backgroundColor:
                              const Color.fromRGBO(18, 18, 18, 0.5),
                          centerTitle: false,
                          pinned: true,
                          expandedHeight:
                              MediaQuery.of(context).size.height * 0.4,
                          flexibleSpace: FlexibleSpaceBar(
                            collapseMode: CollapseMode.parallax,
                            background: FittedBox(
                              fit: BoxFit.fill,
                              child: TrailerWatch(
                                trailerytid: state.SeriesTrailersList.isNotEmpty
                                    ? state.SeriesTrailersList[0]['key']
                                    : '', // Series Trailer Key
                              ),
                            ),
                          )),
                      SliverList(
                          delegate: SliverChildListDelegate([
                        Column(
                          children: [
                            // Genres display
                            Row(children: [
                              Container(
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 10),
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: state.SeriesGenres.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: const Color.fromRGBO(
                                                    25, 25, 25, 1),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: genrestext(
                                                state.SeriesGenres[index]));
                                      })),
                            ]),

                            // Runtime or number of episodes
                            Row(
                              children: [
                                Container(
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.only(
                                        left: 10, top: 10),
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color:
                                            const Color.fromRGBO(25, 25, 25, 1),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: genrestext(
                                        '${state.SeriesDetails[0]['number_of_episodes']} Episodes'))
                              ],
                            )
                          ],
                        ),

                        Padding(
                            padding: const EdgeInsets.only(left: 20, top: 10),
                            child: tittletext('Series Story :')),
                        Padding(
                            padding: const EdgeInsets.only(left: 20, top: 10),
                            child: overviewtext(
                                state.SeriesDetails[0]['overview'].toString())),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 10),
                          child: ReviewUI(revdeatils: state.userReviewsSeries),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left: 20, top: 20),
                            child: normaltext(
                                'First Air Date : ${state.SeriesDetails[0]['first_air_date'].toString().substring(0, 4)}')),

                        // Seasons and Episodes

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20, top: 20),
                              child: tittletext('Seasons:'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20, top: 20),
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: DropdownButton<String>(
                                  style: const TextStyle(color: Colors.white),
                                  alignment: AlignmentDirectional.bottomCenter,
                                  underline: const SizedBox(),
                                  icon: const Icon(Icons.arrow_drop_down,
                                      color: Colors.white),
                                  dropdownColor: Colors.black.withOpacity(0.6),
                                  onChanged: (value) {
                                    if (value != null) {
                                      final seasonNumber = int.parse(value);
                                      cubit.selectedSeason = value;

                                      // Fetch episodes for the selected season
                                      cubit.fetchEpisodesForSeason(
                                          id, seasonNumber);
                                    }
                                  },
                                  value: cubit.selectedSeason,
                                  items: state.SeasonsList.map<
                                      DropdownMenuItem<String>>((season) {
                                    return DropdownMenuItem<String>(
                                      value: season['season_number'].toString(),
                                      child: Text(
                                          'Season ${season['season_number']}'),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height(context) * 0.4,
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20, top: 20),
                              child: state.SeasonsList.firstWhere(
                                          (season) =>
                                              season['season_number']
                                                  .toString() ==
                                              cubit.selectedSeason,
                                          orElse: () =>
                                              {'episodes': []})['episodes']
                                      .isEmpty
                                  ? const Center(
                                      child: Text('No episodes available'))
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: state.SeasonsList.firstWhere(
                                              (season) =>
                                                  season['season_number']
                                                      .toString() ==
                                                  cubit.selectedSeason,
                                              orElse: () =>
                                                  {'episodes': []})['episodes']
                                          .length,
                                      itemBuilder: (context, index) {
                                        var episode =
                                            state.SeasonsList.firstWhere(
                                                (season) =>
                                                    season['season_number']
                                                        .toString() ==
                                                    cubit.selectedSeason,
                                                orElse: () => {
                                                      'episodes': []
                                                    })['episodes'][index];
                                        return ListTile(
                                          title: Text(
                                              'Episode ${episode['episode_number']}: ${episode['episode_name']}'),
                                          subtitle: Text(
                                              'Air Date: ${episode['air_date']}'),
                                        );
                                      },
                                    ),
                            ),
                          ),
                        ),
                        state.similarSeriesList.isNotEmpty
                            ? sliderList(
                                state.similarSeriesList,
                                "Similar Series",
                                "Tv",
                                state.similarSeriesList.length)
                            : SizedBox(),
                        state.recommendedSeriesList.isNotEmpty
                            ? sliderList(
                                state.recommendedSeriesList,
                                "Recommended Series",
                                "Tv",
                                state.recommendedSeriesList.length)
                            : SizedBox(),
                      ]))
                    ]);
              } else {
                return Center(child: Text('No results found'));
              }
            } else if (state is SeriesDetailsError) {
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
