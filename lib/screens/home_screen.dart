import 'package:flutter/material.dart';
import 'package:netflixclone/models/now_playing_movies_model.dart';
import 'package:netflixclone/models/tv_series_model.dart';

import 'package:netflixclone/models/upcoming_movie_models.dart';
import 'package:netflixclone/screens/search.dart';
import 'package:netflixclone/services.dart/api_services.dart';
import 'package:netflixclone/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  late Future<UpcomingMovieModel> upcompingfuture;
  late Future<UpcomingMovieModel> nowplayingfuture;
  late Future<TvSeriesModel> tvseries;

  ApiServices api = ApiServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    upcompingfuture = api.getUpcomingMovieModel();
    nowplayingfuture = api.getNowPlayingModel();
    tvseries = api.getTvseries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Image.asset(
            "assets/logo.png",
            height: 70,
            width: 100,
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SearchScreen()));
              },
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    color: Colors.blueAccent,
                    height: 28,
                    width: 28,
                  )),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                FutureBuilder(
                    future: tvseries,
                    builder: (context, snapshot) {
                      return (snapshot.hasData)
                          ? CustumCourselSlider(data: snapshot.data!)
                          : SizedBox.shrink();
                    }),

                MovieCard(movies: upcompingfuture, title: "Upcoming Movies"),
                // SizedBox(
                //   height: 5,
                // ),
                MovieCard(
                  movies: nowplayingfuture,
                  title: "Now playing",
                ),
              ],
            ),
          ),
        ));
  }
}
