import 'package:bingebox/constants/width_and_height.dart';
import 'package:flutter/material.dart';

import '../view/details_screen/movie_details_screen.dart';
import '../view/details_screen/series_details_screen.dart';

Widget sliderList(List firstListname, String title, String type, int itemCount) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: <Widget>[
    Padding(
      padding: const EdgeInsets.only(left: 10, top: 15, bottom: 20),
      child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 18)),
    ),
    SizedBox(
      height: 250,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (type == 'movie') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MovieDetailsScreen(movieId: firstListname[index]['id'])),
                );
              } else if (type == 'Tv') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SeriesDetailsScreen(id: firstListname[index]['id'])),
                );
              }
            },
            child: Container(
              width: 170,
              margin: const EdgeInsets.only(left: 13),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'https://image.tmdb.org/t/p/w500${firstListname[index]['poster_path']}')),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 2),
                    child: Text(
                      _formatDate(firstListname[index]['Date']) ??
                          _formatDate(firstListname[index]['first_air_date']) ?? 'Unknown',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0, top: 2),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 2,
                            left: 5,
                            bottom: 2,
                            right: 5,
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.star, color: Colors.yellow, size: 15),
                              SizedBox(width: width(context) * 0.01),
                              Text(
                                firstListname[index]['vote_average'].toString().substring(0, 3),
                                style: const TextStyle(
                                    color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )),
                  )
                ],
              ),
            ),
          );
        },
      ),
    ),
  ],
);

// Helper function to safely handle date formatting
String? _formatDate(String? date) {
  if (date != null && date.length >= 4) {
    return date.substring(0, 4);
  }
  return null;
}
