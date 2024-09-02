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
  List<Map<String, dynamic>> trendinglist = [];
  int dropDown = 1;
  List<DropdownMenuItem> itemDrop = [
    const DropdownMenuItem(value: 1,
      child: Text('Weekly',
      style: TextStyle(
          decoration: TextDecoration.none,
          color: Colors.white,
          fontSize: 16
      ),
    ),
    ),
    const DropdownMenuItem(value: 2,
      child: Text('daily',
      style: TextStyle(
          decoration: TextDecoration.none,
          color: Colors.white,
          fontSize: 16
      ),
    ),
    ),
  ];

  Future<void> trendinglisthome() async {
    if(dropDown==1)
      {
        await http.get(
          Uri.parse(
              'https://api.themoviedb.org/3/trending/all/week?api_key=5ebe7170f95aab31d81fb727f86382a4'),
        ).then((trendingweekresponse) {
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
            emit(RelodedMovieDoneState());
          } else {
            emit(RelodedMovieErrorState());
          }
        }).catchError((error) {
          print("Error: $error");
          emit(RelodedMovieErrorState());
        });
      }
    else{
      await http.get(
        Uri.parse('https://api.themoviedb.org/3/trending/all/day?api_key=5ebe7170f95aab31d81fb727f86382a4'),
      ).then((trendingweekresponse) {
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
          emit(RelodedMovieDoneState());
        } else {
          emit(RelodedMovieErrorState());
        }
      }).catchError((error) {
        print("Error: $error");
        emit(RelodedMovieErrorState());
      });
    }
  }
  List<Widget> tab=[
    const Tab(
      child: Text(
        'Tv Series',
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    ),
    const Tab(
      child: Text('Movies',
          style: TextStyle(color: Colors.white, fontSize: 18)),
    ),
    const Tab(
      child: Text('Upcoming',
          style: TextStyle(color: Colors.white, fontSize: 18)),
    ),
  ];

  List<Widget> tabScreen=
  [
    const TvSeriesScreen(),
    const MoviesScreen(),
    const UpcomingScreen(),
  ];

  List<Map<String, dynamic>> serires = [];
  Future<void> Serieslisthome() async {
    await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/tv/top_rated?api_key=5ebe7170f95aab31d81fb727f86382a4'),
    ).then((SeriesResponse) {
      if (SeriesResponse.statusCode == 200) {
        var tempdata = jsonDecode(SeriesResponse.body);
        var Seriesjson = tempdata['results'];
        for (var item in Seriesjson) {
          serires.add({
            'name': item['name'],
            'id': item['id'],
            'Date': item['first_air_date'],
            'poster_path': item['poster_path'],
            'vote_average': item['vote_average'],
          });
        }
        emit(RelodedSeriesDoneState());
      } else {
        emit(RelodedSeriesErrorState());
      }
    }).catchError((error) {
      print("Error: $error");
      emit(RelodedSeriesErrorState());
    });
  }
}

