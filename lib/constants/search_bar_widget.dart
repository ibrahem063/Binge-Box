import 'package:bingebox/constants/color.dart';
import 'package:bingebox/constants/cubit/cubit.dart';
import 'package:bingebox/constants/cubit/states.dart';
import 'package:bingebox/constants/width_and_height.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view/details_screen/checker_screen.dart';


class SearchBarFun extends StatelessWidget {

  SearchBarFun({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = bingeboxCubit.get(context);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 30, bottom: 20, right: 10),
        child: Column(
          children: [
            Container(
              height: 50,
              width:width(context),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: TextField(
                style: const TextStyle(color: Colors.white,fontSize: 20),
                autofocus: false,
                 controller: cubit.searchText,
                keyboardType:TextInputType.text ,
                onSubmitted: (value) {
                  cubit.searchMovies(value);
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                onChanged: (value) {
                  cubit.searchMovies(value);
                },
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      cubit.searchText.clear();
                      FocusManager.instance.primaryFocus?.unfocus();
                      cubit.searchMovies('');
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Colors.red.withOpacity(0.6),
                    ),
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.red,
                  ),
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.2),),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 5),
            BlocBuilder<bingeboxCubit, bingeboxStates>(
              builder: (context, state) {
                if (state is SearchLoadedState && state.searchResults.isNotEmpty) {
                  return SizedBox(
                    height: 400,
                    child: ListView.builder(
                      itemCount: state.searchResults.length,
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        var searchResult = state.searchResults[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CheckerScreen(
                                  searchResult['id'],
                                  searchResult['media_type'],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 4, bottom: 4),
                            height: 180,
                            decoration:  BoxDecoration(
                              color: backgroundColor,
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        'https://image.tmdb.org/t/p/w500${searchResult['poster_path']}',
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${searchResult['media_type']}',
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(5),
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: Colors.amber.withOpacity(0.2),
                                              borderRadius: const BorderRadius.all(Radius.circular(6)),
                                            ),
                                            child: Row(
                                              children: [
                                                const Icon(Icons.star, color: Colors.amber, size: 20),
                                                const SizedBox(width: 5),
                                                Text(
                                                  '${searchResult['vote_average']}',
                                                  style: const TextStyle(color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Container(
                                            padding: const EdgeInsets.all(5),
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: Colors.amber.withOpacity(0.2),
                                              borderRadius: const BorderRadius.all(Radius.circular(8)),
                                            ),
                                            child: Row(
                                              children: [
                                                const Icon(Icons.people_outline_sharp, color: Colors.red, size: 20),
                                                const SizedBox(width: 5),
                                                Text(
                                                  '${searchResult['popularity']}',
                                                  style: const TextStyle(color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.4,
                                        height: 85,
                                        child: Text(
                                          '${searchResult['overview']}',
                                          style: const TextStyle(fontSize: 12, color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else if (state is SearchLoadingState) {
                  return const Center(child: CircularProgressIndicator(color: Colors.red));
                } else if (state is SearchErrorState) {
                  return Center(
                    child: Text(
                      'Error: ${state.errorMessage}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                } else {
                  return Container(); // Display an empty container if no results
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
