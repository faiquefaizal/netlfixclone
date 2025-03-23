import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflixclone/common/utiles.dart';
import 'package:netflixclone/models/detailed_info.dart';
import 'package:netflixclone/models/recommandation_model.dart';
import 'package:netflixclone/services.dart/api_services.dart';

class DetailedMovieScreen extends StatefulWidget {
  final int movieId;
  const DetailedMovieScreen({super.key, required this.movieId});

  @override
  State<DetailedMovieScreen> createState() => _DetailedMovieScreenState();
}

class _DetailedMovieScreenState extends State<DetailedMovieScreen> {
  late Future<DetailedInfo> detailedscreen;
  ApiServices api = ApiServices();
  late Future<Recommandation> recomnad;
  @override
  void initState() {
    // TODO: implement initState
    log(widget.movieId.toString());
    fetchdetails();
    super.initState();
  }

  fetchdetails() {
    detailedscreen = api.getDetailedInfo(widget.movieId);
    recomnad = api.getRecommandation(widget.movieId);
    setState(() {});
  }
  // fetchdetails() async {
  //   try {
  //     log("Fetching details for Movie ID: ${widget.movieId}");

  //     // Wait for API response
  //     var fetchedData = await api.getDetailedInfo(widget.movieId);

  //     log("API Response: $fetchedData");

  //     setState(() {
  //       detailedscreen = Future.value(fetchedData);
  //     });
  //   } catch (e) {
  //     log("Error fetching details: $e");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: detailedscreen,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var movie = snapshot.data;
              String genresTExt = movie!.genres.map((e) => e.name).join(", ");
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    "$imagePath${movie?.posterPath}"),
                                fit: BoxFit.cover),
                          ),
                          child: SafeArea(
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      icon: Icon(
                                        Icons.arrow_back_ios,
                                        color: Colors.white,
                                      )),
                                ]),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.name,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                movie.firstAirDate.year.toString(),
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Flexible(
                                child: Text(
                                  genresTExt,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            movie.overview,
                            textAlign: TextAlign.start,
                            maxLines: 7,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    FutureBuilder(
                        future: recomnad,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var datas = snapshot.data;

                            return datas!.results.isEmpty
                                ? SizedBox()
                                : Column(
                                    children: [
                                      Text(
                                        "More like this",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 20),
                                      ),
                                      GridView.builder(
                                          itemCount: datas.results.length,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 3,
                                                  mainAxisSpacing: 15,
                                                  crossAxisSpacing: 5,
                                                  childAspectRatio: 1.2 / 2),
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                Navigator.of(context).pushReplacement(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            DetailedMovieScreen(
                                                                movieId: datas
                                                                    .results[
                                                                        index]
                                                                    .id)));
                                              },
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    "$imagePath${datas.results[index].posterPath}",
                                                fit: BoxFit.cover,
                                              ),
                                            );
                                          })
                                    ],
                                  );
                          }
                          return const Text("Something went wrong");
                        })
                  ],
                ),
              );
            } else {
              log("snap is empty");
              return SizedBox();
            }
          }),
    );
  }
}
