import 'package:flutter/material.dart';
import 'package:netflixclone/common/utiles.dart';
import 'package:netflixclone/models/tv_series_model.dart';
import 'package:netflixclone/models/upcoming_movie_models.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:netflixclone/screens/detailed_movie_screen.dart';

class MovieCard extends StatefulWidget {
  final Future<UpcomingMovieModel> movies;
  final String title;
  MovieCard({super.key, required this.movies, required this.title});

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.movies,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var datas = snapshot.data?.results;
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20),
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: datas!.length,
                    itemBuilder: (context, index) {
                      var data = datas[index];
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  DetailedMovieScreen(movieId: data.id)));
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Image.network("$imagePath${data.posterPath}"),
                        ),
                      );
                    },
                  ),
                )
              ],
            );
          } else {
            return SizedBox.shrink();
          }
        });
  }
}

class CustumCourselSlider extends StatelessWidget {
  final TvSeriesModel data;

  const CustumCourselSlider({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
        width: size.width,
        height: (size.height * 0.4 < 300) ? 300 : size.height * 0.4,
        child: CarouselSlider.builder(
            itemCount: data.results.length,
            itemBuilder: (context, index, realindex) {
              var url = data.results[index].backdropPath;
              return GestureDetector(
                child: Column(
                  children: [
                    CachedNetworkImage(imageUrl: "$imagePath$url"),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      data.results[index].name,
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              );
            },
            options: CarouselOptions(
                height: (size.height * 0.4 < 300) ? 300 : size.height * 0.4,
                aspectRatio: 16 / 9,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                enlargeCenterPage: true,
                initialPage: 0)));
  }
}

class ComingSoonMovieWidget extends StatelessWidget {
  final String imageUrl;
  final String overview;
  final String logoUrl;
  final String month;
  final String day;

  const ComingSoonMovieWidget({
    super.key,
    required this.imageUrl,
    required this.overview,
    required this.logoUrl,
    required this.month,
    required this.day,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      // height: size.width * 0.85,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  month,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.grey),
                ),
                Text(day,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        letterSpacing: 2,
                        color: Colors.white))
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(imageUrl: imageUrl),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: size.width * 0.5,
                      height: size.width * 0.2,
                      child: CachedNetworkImage(
                        imageUrl: logoUrl,
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                    const Spacer(),
                    const Column(
                      children: [
                        Icon(
                          Icons.notifications_none_rounded,
                          size: 25,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Remind Me',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 8,
                              color: Colors.white),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Column(
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          size: 25,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Info',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 8,
                              color: Colors.white),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Coming on $month $day',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.5,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      overview,
                      textAlign: TextAlign.left,
                      maxLines: 3,
                      style:
                          const TextStyle(color: Colors.grey, fontSize: 12.5),
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
