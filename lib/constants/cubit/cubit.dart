import 'dart:convert';
import 'package:bingebox/constants/cubit/states.dart';
import 'package:bingebox/view/home_screen/section_screen/movies_screen/movies_screen.dart';
import 'package:bingebox/view/home_screen/section_screen/tv_series_screen/tv_series_screen.dart';
import 'package:bingebox/view/home_screen/section_screen/upcoming_screen/upcoming_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../controller/api_key.dart';

class bingeboxCubit extends Cubit<bingeboxStates> {

  bingeboxCubit() : super(bingeboxInitialState());

  static bingeboxCubit get(context) => BlocProvider.of(context);

  bool showSpin = false;
  bool isChecked = false;
  var email = TextEditingController();
  var password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<Map<dynamic, dynamic>> trendinglist = [];
  int dropDown = 1;
  String? selectedSeason;
  List<Map<String, dynamic>>? selectedSeasonEpisodes;

  List<DropdownMenuItem> itemDrop = [
    const DropdownMenuItem(
      value: 1,
      child: Text(
        'Weekly',
        style: TextStyle(
            decoration: TextDecoration.none, color: Colors.white, fontSize: 16),
      ),
    ),
    const DropdownMenuItem(
      value: 2,
      child: Text(
        'daily',
        style: TextStyle(
            decoration: TextDecoration.none, color: Colors.white, fontSize: 16),
      ),
    ),
  ];

  Future<void> trendinglisthome() async {
    emit(TrendingLoadingState());
    if (dropDown == 1) {
      await http
          .get(
        Uri.parse(
            'https://api.themoviedb.org/3/trending/all/week?api_key=5ebe7170f95aab31d81fb727f86382a4'),
      )
          .then((trendingweekresponse) {
        if (trendingweekresponse.statusCode == 200) {
          var tempdata = jsonDecode(trendingweekresponse.body);
          var trendingweekjson = tempdata['results'];
          trendinglist.clear(); // تفريغ القائمة قبل إضافة العناصر الجديدة
          for (var item in trendingweekjson) {
            trendinglist.add({
              'id': item['id'],
              'poster_path': item['poster_path'],
              'vote_average': item['vote_average'],
              'media_type': item['media_type'],
              'indexno': 1
            });
          }
          emit(TrendingDoneState());
        } else {
          emit(TrendingErrorState());
        }
      }).catchError((error) {
        print("Error: $error");
        emit(TrendingErrorState());
      });
    } else {
      await http
          .get(
        Uri.parse(
            'https://api.themoviedb.org/3/trending/all/day?api_key=5ebe7170f95aab31d81fb727f86382a4'),
      )
          .then((trendingweekresponse) {
        if (trendingweekresponse.statusCode == 200) {
          var tempdata = jsonDecode(trendingweekresponse.body);
          var trendingweekjson = tempdata['results'];
          trendinglist.clear(); // تفريغ القائمة قبل إضافة العناصر الجديدة
          for (var item in trendingweekjson) {
            trendinglist.add({
              'id': item['id'],
              'poster_path': item['poster_path'],
              'vote_average': item['vote_average'],
              'media_type': item['media_type'],
              'indexno': 1
            });
          }
          emit(TrendingDoneState());
        } else {
          emit(TrendingErrorState());
        }
      }).catchError((error) {
        print("Error: $error");
        emit(TrendingErrorState());
      });
    }
  }

  List<Widget> tab = [
    const Tab(
      child: Text(
        'Tv Series',
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    ),
    const Tab(
      child:
          Text('Movies', style: TextStyle(color: Colors.white, fontSize: 18)),
    ),
    const Tab(
      child:
          Text('Upcoming', style: TextStyle(color: Colors.white, fontSize: 18)),
    ),
  ];

  List<Widget> tabScreen = [
    const TvSeriesScreen(),
    const MoviesScreen(),
    const UpcomingScreen(),
  ];

  List<Map<String, dynamic>> popularseries = [];
  List<Map<String, dynamic>> toprated = [];
  List<Map<String, dynamic>> ontheair = [];

  Future<void> Serieslisthome() async {
    // إعلانات الواجهة
    emit(SeriesLoadingState());

    await http
        .get(
      Uri.parse(
          'https://api.themoviedb.org/3/tv/popular?api_key=5ebe7170f95aab31d81fb727f86382a4'),
    )
        .then((trendingweekresponse) {
      if (trendingweekresponse.statusCode == 200) {
        var tempdata = jsonDecode(trendingweekresponse.body);
        var seriesjson = tempdata['results'];
        popularseries.clear(); // تفريغ القائمة قبل إضافة العناصر الجديدة
        for (var item in seriesjson) {
          popularseries.add({
            'name': item['name'],
            'id': item['id'],
            'Date': item['first_air_date'],
            'poster_path': item['poster_path'],
            'vote_average': item['vote_average'],
          });
        }
        emit(SeriesDoneState());
      } else {
        emit(SeriesErrorState());
      }
    }).catchError((error) {
      print("Error: $error");
      emit(SeriesErrorState());
    });

    await http
        .get(
      Uri.parse(
          'https://api.themoviedb.org/3/tv/top_rated?api_key=5ebe7170f95aab31d81fb727f86382a4'),
    )
        .then((trendingweekresponse) {
      if (trendingweekresponse.statusCode == 200) {
        var tempdata = jsonDecode(trendingweekresponse.body);
        var seriesjson = tempdata['results'];
        toprated.clear(); // تفريغ القائمة قبل إضافة العناصر الجديدة
        for (var item in seriesjson) {
          toprated.add({
            'name': item['name'],
            'id': item['id'],
            'Date': item['first_air_date'],
            'poster_path': item['poster_path'],
            'vote_average': item['vote_average'],
          });
        }
        emit(SeriesDoneState());
      } else {
        emit(SeriesErrorState());
      }
    }).catchError((error) {
      print("Error: $error");
      emit(SeriesErrorState());
    });

    await http
        .get(
      Uri.parse(
          'https://api.themoviedb.org/3/tv/on_the_air?api_key=5ebe7170f95aab31d81fb727f86382a4'),
    )
        .then((trendingweekresponse) {
      if (trendingweekresponse.statusCode == 200) {
        var tempdata = jsonDecode(trendingweekresponse.body);
        var seriesjson = tempdata['results'];
        ontheair.clear(); // تفريغ القائمة قبل إضافة العناصر الجديدة
        for (var item in seriesjson) {
          ontheair.add({
            'name': item['name'],
            'id': item['id'],
            'Date': item['first_air_date'],
            'poster_path': item['poster_path'],
            'vote_average': item['vote_average'],
          });
        }
        emit(SeriesDoneState());
      } else {
        emit(SeriesErrorState());
      }
    }).catchError((error) {
      print("Error: $error");
      emit(SeriesErrorState());
    });
  }

  List<Map<String, dynamic>> popularmovies = [];
  List<Map<String, dynamic>> topratedmovies = [];
  List<Map<String, dynamic>> nowmovies = [];
  List<Map<String, dynamic>> upcomingmovie = [];


  Future<void> movieslisthome() async {
    // إعلانات الواجهة
    emit(MoviesLoadingState());

    await http
        .get(
      Uri.parse(
          'https://api.themoviedb.org/3/movie/popular?api_key=5ebe7170f95aab31d81fb727f86382a4'),
    )
        .then((trendingweekresponse) {
      if (trendingweekresponse.statusCode == 200) {
        var tempdata = jsonDecode(trendingweekresponse.body);
        var seriesjson = tempdata['results'];
        popularmovies.clear(); // تفريغ القائمة قبل إضافة العناصر الجديدة
        for (var item in seriesjson) {
          popularmovies.add({
            'name': item['name'],
            'id': item['id'],
            'Date': item['release_date'],
            'poster_path': item['poster_path'],
            'vote_average': item['vote_average'],
          });
        }
        emit(MoviesDoneState());
      } else {
        emit(MoviesErrorState());
      }
    }).catchError((error) {
      print("Error: $error");
      emit(MoviesErrorState());
    });

    await http
        .get(
      Uri.parse(
          'https://api.themoviedb.org/3/movie/top_rated?api_key=5ebe7170f95aab31d81fb727f86382a4'),
    )
        .then((trendingweekresponse) {
      if (trendingweekresponse.statusCode == 200) {
        var tempdata = jsonDecode(trendingweekresponse.body);
        var seriesjson = tempdata['results'];
        topratedmovies.clear(); // تفريغ القائمة قبل إضافة العناصر الجديدة
        for (var item in seriesjson) {
          topratedmovies.add({
            'name': item['name'],
            'id': item['id'],
            'Date': item['release_date'],
            'poster_path': item['poster_path'],
            'vote_average': item['vote_average'],
          });
        }
        emit(MoviesDoneState());
      } else {
        emit(MoviesErrorState());
      }
    }).catchError((error) {
      print("Error: $error");
      emit(MoviesErrorState());
    });

    await http
        .get(
      Uri.parse(
          'https://api.themoviedb.org/3/movie/now_playing?api_key=5ebe7170f95aab31d81fb727f86382a4'),
    )
        .then((trendingweekresponse) {
      if (trendingweekresponse.statusCode == 200) {
        var tempdata = jsonDecode(trendingweekresponse.body);
        var seriesjson = tempdata['results'];
        nowmovies.clear(); // تفريغ القائمة قبل إضافة العناصر الجديدة
        for (var item in seriesjson) {
          nowmovies.add({
            'name': item['name'],
            'id': item['id'],
            'Date': item['release_date'],
            'poster_path': item['poster_path'],
            'vote_average': item['vote_average'],
          });
        }
        emit(MoviesDoneState());
      } else {
        emit(MoviesErrorState());
      }
    }).catchError((error) {
      print("Error: $error");
      emit(MoviesErrorState());
    });

    await http
        .get(
      Uri.parse(
          'https://api.themoviedb.org/3/movie/upcoming?api_key=5ebe7170f95aab31d81fb727f86382a4'),
    )
        .then((trendingweekresponse) {
      if (trendingweekresponse.statusCode == 200) {
        var tempdata = jsonDecode(trendingweekresponse.body);
        var seriesjson = tempdata['results'];
        upcomingmovie.clear(); // تفريغ القائمة قبل إضافة العناصر الجديدة
        for (var item in seriesjson) {
          upcomingmovie.add({
            'name': item['name'],
            'id': item['id'],
            'Date': item['release_date'],
            'poster_path': item['poster_path'],
            'vote_average': item['vote_average'],
          });
        }
        emit(MoviesDoneState());
      } else {
        emit(MoviesErrorState());
      }
    }).catchError((error) {
      print("Error: $error");
      emit(MoviesErrorState());
    });
  }

  //details

  Future<void> fetchMovieDetails(int movieId) async {
    emit(MovieDetailsLoading());

    try {
      List<Map<String, dynamic>> movieDetails = [];
      List<Map<String, dynamic>> userReviews = [];
      List<Map<String, dynamic>> similarMoviesList = [];
      List<Map<String, dynamic>> recommendedMoviesList = [];
      List<Map<String, dynamic>> movieTrailersList = [];
      List<String> moviesGenres = [];

      var moviedetailurl = 'https://api.themoviedb.org/3/movie/$movieId?api_key=$apikey';
      var UserReviewurl = 'https://api.themoviedb.org/3/movie/$movieId/reviews?api_key=$apikey';
      var similarmoviesurl = 'https://api.themoviedb.org/3/movie/$movieId/similar?api_key=$apikey';
      var recommendedmoviesurl = 'https://api.themoviedb.org/3/movie/$movieId/recommendations?api_key=$apikey';
      var movietrailersurl = 'https://api.themoviedb.org/3/movie/$movieId/videos?api_key=$apikey';

      // Fetch Movie Details
      var moviedetailresponse = await http.get(Uri.parse(moviedetailurl));
      if (moviedetailresponse.statusCode == 200) {
        var moviedetailjson = jsonDecode(moviedetailresponse.body);
        movieDetails.add({
          "backdrop_path": moviedetailjson['backdrop_path'],
          "title": moviedetailjson['title'],
          "vote_average": moviedetailjson['vote_average'],
          "overview": moviedetailjson['overview'],
          "release_date": moviedetailjson['release_date'],
          "runtime": moviedetailjson['runtime'],
          "budget": moviedetailjson['budget'],
          "revenue": moviedetailjson['revenue'],
        });
        for (var genre in moviedetailjson['genres']) {
          moviesGenres.add(genre['name']);
        }
      }

      // Fetch User Reviews
      var UserReviewresponse = await http.get(Uri.parse(UserReviewurl));
      if (UserReviewresponse.statusCode == 200) {
        var UserReviewjson = jsonDecode(UserReviewresponse.body);
        for (var review in UserReviewjson['results']) {
          userReviews.add({
            "name": review['author'],
            "review": review['content'],
            "rating": review['author_details']['rating']?.toString() ?? "Not Rated",
            "avatarphoto": review['author_details']['avatar_path'] == null
                ? "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png"
                : "https://image.tmdb.org/t/p/w500${review['author_details']['avatar_path']}",
            "creationdate": review['created_at'].substring(0, 10),
            "fullreviewurl": review['url'],
          });
        }
      }

      // Fetch Similar Movies
      var similarmoviesresponse = await http.get(Uri.parse(similarmoviesurl));
      if (similarmoviesresponse.statusCode == 200) {
        var similarmoviesjson = jsonDecode(similarmoviesresponse.body);
        for (var movie in similarmoviesjson['results']) {
          similarMoviesList.add({
            "poster_path": movie['poster_path'],
            "name": movie['title'],
            "vote_average": movie['vote_average'],
            "Date": movie['release_date'],
            "id": movie['id'],
          });
        }
      }

      // Fetch Recommended Movies
      var recommendedmoviesresponse = await http.get(Uri.parse(recommendedmoviesurl));
      if (recommendedmoviesresponse.statusCode == 200) {
        var recommendedmoviesjson = jsonDecode(recommendedmoviesresponse.body);
        for (var movie in recommendedmoviesjson['results']) {
          recommendedMoviesList.add({
            "poster_path": movie['poster_path'],
            "name": movie['title'],
            "vote_average": movie['vote_average'],
            "Date": movie['release_date'],
            "id": movie['id'],
          });
        }
      }

      // Fetch Movie Trailers
      var movietrailersresponse = await http.get(Uri.parse(movietrailersurl));
      if (movietrailersresponse.statusCode == 200) {
        var movietrailersjson = jsonDecode(movietrailersresponse.body);
        for (var trailer in movietrailersjson['results']) {
          if (trailer['type'] == "Trailer") {
            movieTrailersList.add({"key": trailer['key']});
          }
        }
      }

      emit(MovieDetailsLoaded(
        movieDetails: movieDetails,
        userReviews: userReviews,
        similarMoviesList: similarMoviesList,
        recommendedMoviesList: recommendedMoviesList,
        movieTrailersList: movieTrailersList,
        moviesGenres: moviesGenres,
      ));
    } catch (e) {
      emit(MovieDetailsError(e.toString()));
    }
  }




  var searchText = TextEditingController();
  Future<void> searchMovies(String query) async {
    if (query.isEmpty) {
      emit(SearchInitialState());
      return;
    }

    emit(SearchLoadingState());

    try {
      var searchUrl = 'https://api.themoviedb.org/3/search/multi?api_key=$apikey&query=$query';
      var response = await http.get(Uri.parse(searchUrl));

      if (response.statusCode == 200) {
        var results = jsonDecode(response.body)['results'];
        List<Map<String, dynamic>> searchResults = [];
        for (var result in results) {
          if (result['id'] != null && result['poster_path'] != null) {
            searchResults.add(result);
          }
        }
        emit(SearchLoadedState(searchResults));
      } else {
        emit(SearchErrorState('Failed to load results'));
      }
    } catch (e) {
      emit(SearchErrorState(e.toString()));
    }
  }
  List<Map<String, dynamic>> seriesDetails = [];
  List<Map<String, dynamic>> userReviewsSeries = [];
  List<Map<String, dynamic>> similarSeriesList = [];
  List<Map<String, dynamic>> recommendedSeriesList = [];
  List<Map<String, dynamic>> seriesTrailersList = [];
  List<Map<String, dynamic>> seasonsList = []; // For seasons and episodes
  List<String> seriesGenres = [];
  Future<void> fetchSeriesDetails(int seriesId) async {
    emit(SeriesDetailsLoading());

    try {

      var seriesDetailUrl = 'https://api.themoviedb.org/3/tv/$seriesId?api_key=$apikey';
      var userReviewUrl = 'https://api.themoviedb.org/3/tv/$seriesId/reviews?api_key=$apikey';
      var similarSeriesUrl = 'https://api.themoviedb.org/3/tv/$seriesId/similar?api_key=$apikey';
      var recommendedSeriesUrl = 'https://api.themoviedb.org/3/tv/$seriesId/recommendations?api_key=$apikey';
      var seriesTrailersUrl = 'https://api.themoviedb.org/3/tv/$seriesId/videos?api_key=$apikey';

      // Fetch Series Details
      var seriesDetailResponse = await http.get(Uri.parse(seriesDetailUrl));
      if (seriesDetailResponse.statusCode == 200) {
        var seriesDetailJson = jsonDecode(seriesDetailResponse.body);
        seriesDetails.add({
          "backdrop_path": seriesDetailJson['backdrop_path'],
          "name": seriesDetailJson['name'], // Title of the series
          "vote_average": seriesDetailJson['vote_average'],
          "overview": seriesDetailJson['overview'],
          "first_air_date": seriesDetailJson['first_air_date'], // First air date of the series
          "number_of_episodes": seriesDetailJson['number_of_episodes'], // Total number of episodes
          "number_of_seasons": seriesDetailJson['number_of_seasons'], // Number of seasons
        });
        for (var genre in seriesDetailJson['genres']) {
          seriesGenres.add(genre['name']);
        }

        // Fetch Seasons and Episodes
        for (var season in seriesDetailJson['seasons']) {
          var seasonId = season['season_number'];
          var seasonEpisodesUrl = 'https://api.themoviedb.org/3/tv/$seriesId/season/$seasonId?api_key=$apikey';
          var seasonEpisodesResponse = await http.get(Uri.parse(seasonEpisodesUrl));

          if (seasonEpisodesResponse.statusCode == 200) {
            // var seasonEpisodesJson = jsonDecode(seasonEpisodesResponse.body);
            // // List<Map<String, dynamic>> episodesList = [];
            //
            // // for (var episode in seasonEpisodesJson['episodes']) {
            // //   episodesList.add({
            // //     "episode_id": episode['id'], // Episode ID
            // //     "episode_number": episode['episode_number'], // Episode number
            // //     "episode_name": episode['name'], // Episode name
            // //     "air_date": episode['air_date'], // Air date
            // //   });
            // // }

            seasonsList.add({
              "season_number": seasonId,
              "season_name": season['name'], // Season name
              // "episodes": episodesList, // List of episodes in the season
            });
          }
        }
      }

      // Fetch User Reviews
      var userReviewResponse = await http.get(Uri.parse(userReviewUrl));
      if (userReviewResponse.statusCode == 200) {
        var userReviewJson = jsonDecode(userReviewResponse.body);
        for (var review in userReviewJson['results']) {
          userReviewsSeries.add({
            "name": review['author'],
            "review": review['content'],
            "rating": review['author_details']['rating']?.toString() ?? "Not Rated",
            "avatarphoto": review['author_details']['avatar_path'] == null
                ? "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png"
                : "https://image.tmdb.org/t/p/w500${review['author_details']['avatar_path']}",
            "creationdate": review['created_at'].substring(0, 10),
            "fullreviewurl": review['url'],
          });
        }
      }

      // Fetch Similar Series
      var similarSeriesResponse = await http.get(Uri.parse(similarSeriesUrl));
      if (similarSeriesResponse.statusCode == 200) {
        var similarSeriesJson = jsonDecode(similarSeriesResponse.body);
        for (var series in similarSeriesJson['results']) {
          similarSeriesList.add({
            "poster_path": series['poster_path'],
            "name": series['name'], // Name of the series
            "vote_average": series['vote_average'],
            "first_air_date": series['first_air_date'], // Air date
            "id": series['id'], // Series ID
          });
        }
      }

      // Fetch Recommended Series
      var recommendedSeriesResponse = await http.get(Uri.parse(recommendedSeriesUrl));
      if (recommendedSeriesResponse.statusCode == 200) {
        var recommendedSeriesJson = jsonDecode(recommendedSeriesResponse.body);
        for (var series in recommendedSeriesJson['results']) {
          recommendedSeriesList.add({
            "poster_path": series['poster_path'],
            "name": series['name'], // Name of the series
            "vote_average": series['vote_average'],
            "first_air_date": series['first_air_date'], // Air date
            "id": series['id'], // Series ID
          });
        }
      }

      // Fetch Series Trailers
      var seriesTrailersResponse = await http.get(Uri.parse(seriesTrailersUrl));
      if (seriesTrailersResponse.statusCode == 200) {
        var seriesTrailersJson = jsonDecode(seriesTrailersResponse.body);
        for (var trailer in seriesTrailersJson['results']) {
          if (trailer['type'] == "Trailer") {
            seriesTrailersList.add({"key": trailer['key']});
          }
        }
      }

      emit(SeriesDetailsLoaded(
        SeriesDetails: seriesDetails,
        userReviewsSeries: userReviewsSeries,
        similarSeriesList: similarSeriesList,
        recommendedSeriesList: recommendedSeriesList,
        SeriesTrailersList: seriesTrailersList,
        SeriesGenres: seriesGenres,
        SeasonsList: seasonsList, // Seasons with episodes
      ));
    } catch (e) {
      emit(SeriesDetailsError(e.toString()));
    }
  }
  Future<void> fetchEpisodesForSeason(int seriesId, int seasonNumber) async {
    try {
      // URL to fetch episodes for the specified season
      var seasonEpisodesUrl = 'https://api.themoviedb.org/3/tv/$seriesId/season/$seasonNumber?api_key=$apikey';
      var seasonEpisodesResponse = await http.get(Uri.parse(seasonEpisodesUrl));

      if (seasonEpisodesResponse.statusCode == 200) {
        var seasonEpisodesJson = jsonDecode(seasonEpisodesResponse.body);
        List<Map<String, dynamic>> episodesList = [];

        for (var episode in seasonEpisodesJson['episodes']) {
          episodesList.add({
            "episode_id": episode['id'],
            "episode_number": episode['episode_number'],
            "episode_name": episode['name'],
            "air_date": episode['air_date'],
          });
        }

        emit(SeriesDetailsLoaded(
          SeriesDetails: seriesDetails,
          userReviewsSeries: userReviewsSeries,
          similarSeriesList: similarSeriesList,
          recommendedSeriesList: recommendedSeriesList,
          SeriesTrailersList: seriesTrailersList,
          SeriesGenres: seriesGenres,
          SeasonsList: seasonsList.map((season) {
            if (season['season_number'] == seasonNumber) {
              return {
                ...season,
                "episodes": episodesList,
              };
            }
            return season;
          }).toList(),
        ));
      }
    } catch (e) {
      emit(SeriesDetailsError(e.toString()));
    }
  }

}
