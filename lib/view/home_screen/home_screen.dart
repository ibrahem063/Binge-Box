import 'package:bingebox/constants/color.dart';
import 'package:bingebox/constants/cubit/cubit.dart';
import 'package:bingebox/constants/cubit/states.dart';
import 'package:bingebox/constants/width_and_height.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    var cubit = bingeboxCubit.get(context);
    TabController _tabController = TabController(length: 3, vsync: this);
    return BlocConsumer<bingeboxCubit, bingeboxStates>(
      listener: (BuildContext context, bingeboxStates state) {},
      builder: (BuildContext context, bingeboxStates state) {
        if (state is RelodedMovieDoneState) {
          return Scaffold(
            backgroundColor: backgroundColor,
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  centerTitle: true,
                  pinned: true,
                  expandedHeight: height(context) * 0.5,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    background: FutureBuilder(
                      future: cubit.trendinglisthome() as Future,
                      builder: (context, snapshot) {
                        return CarouselSlider(
                            items: cubit.trendinglist.map((i) {
                              return Builder(
                                builder: (context) {
                                  return GestureDetector(
                                    onTap: () {},
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        width: width(context),
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                          colorFilter: ColorFilter.mode(
                                            Colors.black.withOpacity(0.3),
                                            BlendMode.darken,
                                          ),
                                          image: NetworkImage(
                                            'https://image.tmdb.org/t/p/w500${i['poster_path']}',
                                          ),
                                          fit: BoxFit.fill,
                                        )),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                            options: CarouselOptions(
                              autoPlay: true,
                              viewportFraction: 1,
                              autoPlayInterval: const Duration(seconds: 2),
                              height: height(context),
                            ));
                      },
                    ),
                  ),
                  backgroundColor: backgroundColor,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Trending' + '   🔥',
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: height(context) * 0.1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 28, left: 4),
                          child: DropdownButton(
                            autofocus: true,
                            icon: const Icon(
                                color: Colors.white, Icons.arrow_drop_down),
                            dropdownColor: Colors.black.withOpacity(0.6),
                            onChanged: (value) {
                              cubit.trendinglist.clear();
                              cubit.dropDown = int.parse(value.toString());
                            },
                            value: cubit.dropDown,
                            items: cubit.itemDrop,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Container(
                      width: width(context),
                      height: height(context) * 0.07,
                      alignment: Alignment.center,
                      child: TabBar(
                        controller: _tabController,
                        isScrollable: true,
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.red.withOpacity(0.4)),
                        tabs: cubit.tab
                      ),
                    ),
                    Container(
                      height: 1050,
                      child: TabBarView(
                        controller: _tabController,
                        children: cubit.tabScreen,
                      ),
                    )
                  ]),
                ),
              ],
            ),
          );
        } else if (state is RelodedMovieErrorState) {
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
