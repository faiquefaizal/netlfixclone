import 'dart:convert';
import 'dart:developer';

import 'package:netflixclone/models/detailed_info.dart';
import 'package:netflixclone/models/now_playing_movies_model.dart';
import 'package:netflixclone/models/recommandation_model.dart';
import 'package:netflixclone/models/search_movie_model.dart';
import 'package:netflixclone/models/top_search.dart';
import 'package:netflixclone/models/tv_series_model.dart';
import 'package:netflixclone/models/upcoming_movie_models.dart';
import 'package:http/http.dart' as http;

const String baseUrl = "https://api.themoviedb.org/3";
const key = "?api_key=377343cded38014c3927fadf1b6613d5";
late String endpoint;

class ApiServices {
  Future<UpcomingMovieModel> getUpcomingMovieModel() async {
    endpoint = "/movie/upcoming";
    final url = "$baseUrl$endpoint$key";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return UpcomingMovieModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("unable to load ");
  }

  Future<UpcomingMovieModel> getNowPlayingModel() async {
    endpoint = "/movie/now_playing";
    final url = "$baseUrl$endpoint$key";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print("success ${response.body}");
      return UpcomingMovieModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("unable to load nowplaying ");
  }

  Future<TvSeriesModel> getTvseries() async {
    endpoint = "/tv/top_rated";
    final url = "$baseUrl$endpoint$key";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log(" ${response.body}");
      return TvSeriesModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("unable to load series ");
  }

  Future<SearchMovie> searchMovie(String searched) async {
    endpoint = "/search/tv?query=";
    final url = "$baseUrl$endpoint$searched";
    log(url);
    var response = await http.get(Uri.parse(url), headers: {
      "Authorization":
          " Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzNzczNDNjZGVkMzgwMTRjMzkyN2ZhZGYxYjY2MTNkNSIsIm5iZiI6MTc0MjQ1NzEwNS45Mjk5OTk4LCJzdWIiOiI2N2RiYzkxMWM2MGQ1MTc3YWRlOWZjNWYiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.QzwJ3FD2tqEK2bNMQvX8d0FjOzV_B4VcZ50X4KAxlPc"
    });
    if (response.statusCode == 200) {
      log("search       ${response.body}");
      return SearchMovie.fromJson(jsonDecode(response.body));
    }
    throw Exception("unable to load series ");
  }

  Future<TvSeriesModel> getTopSearch() async {
    endpoint = "/tv/top_rated";
    final url = "$baseUrl$endpoint$key";
    log("Top search url");
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log("searh ${response.body}");
      return TvSeriesModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("unable to load top search");
  }
  // Future<TopSearch> getTopSearch() async {
  //   endpoint = "/movie/popular";
  //   final url = "$baseUrl$endpoint$key";
  //   log("Fetching: $url");

  //   try {
  //     var response = await http.get(Uri.parse(url));
  //     log("Response Status Code: ${response.statusCode}");

  //     if (response.statusCode == 200) {
  //       log("Raw API Response: ${response.body}");

  //       var decodedJson = jsonDecode(response.body);
  //       if (decodedJson == null) {
  //         throw Exception("Decoded JSON is null");
  //       }

  //       if (!decodedJson.containsKey("results")) {
  //         throw Exception("Missing 'results' key in API response");
  //       }

  //       var topSearch = TopSearch.fromJson(decodedJson);
  //       log("Parsed TopSearch Object: $topSearch");

  //       return topSearch;
  //     } else {
  //       throw Exception("HTTP Error: ${response.statusCode}");
  //     }
  //   } catch (e) {
  //     log("Error fetching top search: $e");
  //     throw Exception("Failed to fetch top search: $e");
  //   }
  // }

  Future<DetailedInfo> getDetailedInfo(int moviesId) async {
    endpoint = "/tv/$moviesId";
    final url = "$baseUrl$endpoint$key";
    log(url);
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log("detailed Info ${response.body}");
      return DetailedInfo.fromJson(jsonDecode(response.body));
    }

    throw Exception("unable to load detailed info");
  }

  Future<Recommandation> getRecommandation(int moviesId) async {
    endpoint = "/movie/$moviesId/recommendations";
    final url = "$baseUrl$endpoint$key";
    log(url);
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log("detailed Info ${response.body}");
      return Recommandation.fromJson(jsonDecode(response.body));
    }

    throw Exception("unable to load recomdation");
  }
}
