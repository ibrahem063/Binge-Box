import 'dart:convert';
import 'package:bingebox/constants/cubit/states.dart';
import 'package:bingebox/view/home_screen/section_screen/movies_screen/movies_screen.dart';
import 'package:bingebox/view/home_screen/section_screen/tv_series_screen/tv_series_screen.dart';
import 'package:bingebox/view/home_screen/section_screen/upcoming_screen/upcoming_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

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
    emit(SeriesLoadingState());

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
}
