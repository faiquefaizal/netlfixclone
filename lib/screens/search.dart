import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflixclone/common/utiles.dart';
import 'package:netflixclone/models/search_movie_model.dart';
import 'package:netflixclone/models/top_search.dart';
import 'package:netflixclone/models/tv_series_model.dart';
import 'package:netflixclone/screens/detailed_movie_screen.dart';
import 'package:netflixclone/services.dart/api_services.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _HomeState();
}

class _HomeState extends State<SearchScreen> {
  TextEditingController searchTextController = TextEditingController();
  ApiServices api = ApiServices();
  SearchMovie? searchMovie;
  late Future<TvSeriesModel> topSearch;
  void search(String searchtext) {
    api.searchMovie(searchtext).then((value) {
      setState(() {
        searchMovie = value;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    topSearch = api.getTopSearch();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              CupertinoSearchTextField(
                padding: EdgeInsets.all(8),
                controller: searchTextController,
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onChanged: (value) {
                  if (value.isEmpty) {
                  } else {
                    search(searchTextController.text);
                  }
                },
                suffixIcon: Icon(
                  Icons.cancel,
                  color: Colors.white,
                ),
                style:
                    TextStyle(color: const Color.fromARGB(255, 232, 231, 231)),
              ),
              (searchTextController.text.isEmpty)
                  ? FutureBuilder(
                      future: topSearch,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var datas = snapshot.data!.results;
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Top Searches",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: datas.length,
                                itemBuilder: (context, index) {
                                  var data = datas[index];
                                  return InkWell(
                                    onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DetailedMovieScreen(
                                                    movieId: data.id))),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 150,
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: (data.posterPath == null)
                                              ? Image.asset(
                                                  "assets/netflix.png",
                                                )
                                              : Image.network(
                                                  "$imagePath${data.posterPath}",
                                                  width: 100,
                                                ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        SizedBox(
                                          width: 250,
                                          child: Text(
                                            data.name,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              )
                            ],
                          );
                        } else {
                          print("not found");
                          return SizedBox.shrink();
                        }
                      })
                  : (searchMovie == null)
                      ? SizedBox.shrink()
                      : GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 15,
                                  crossAxisSpacing: 5,
                                  childAspectRatio: 1.2 / 2),
                          itemCount: searchMovie?.results.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => DetailedMovieScreen(
                                        movieId:
                                            searchMovie!.results[index].id)));
                              },
                              child: Column(
                                children: [
                                  (searchMovie!.results[index].backdropPath ==
                                          null)
                                      ? Image.asset("assets/netflix.png",
                                          height: 170)
                                      : CachedNetworkImage(
                                          imageUrl:
                                              "$imagePath${searchMovie!.results[index].backdropPath}",
                                          height: 170,
                                        ),
                                  Text(
                                    searchMovie!.results[index].originalName,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        overflow: TextOverflow.ellipsis),
                                  )
                                ],
                              ),
                            );
                          })
            ]),
          ),
        ),
      ),
    );
  }
}
