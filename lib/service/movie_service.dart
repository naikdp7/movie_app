import 'package:movie_app/model/movie_detail_response_model.dart';
import 'package:movie_app/model/movie_response_model.dart';
import 'dart:convert';
import 'package:http/http.dart' show Client;

class MovieService {
  Client client = Client();
  var _apiKey = "7073ed9ff2173368b5be3f46e9392fc7";
  var _baseUrl = "http://api.themoviedb.org/3/movie";

  Future<MovieRS> downloadPopularMovies() async {
    var response = await client.get("$_baseUrl/popular?api_key=$_apiKey");
    return MovieRS.fromJSON(json.decode(response.body));
  }

  Future<MovieRS> downloadLatestMovies() async {
    var response = await client.get("$_baseUrl/latest?api_key=$_apiKey");
    return MovieRS.fromJSON(json.decode(response.body));
  }

  Future<MovieRS> downloadTopRatedMovies() async {
    var response = await client.get("$_baseUrl/top_rated?api_key=$_apiKey");
    return MovieRS.fromJSON(json.decode(response.body));
  }

  Future<MovieRS> downloadUpComingMovies() async {
    var response = await client.get("$_baseUrl/upcoming?api_key=$_apiKey");
    return MovieRS.fromJSON(json.decode(response.body));
  }

  Future<MovieDetailRS> downloadMovieDetail(int movieId) async {
    var response = await client.get("$_baseUrl/$movieId?api_key=$_apiKey");
    return MovieDetailRS.fromJson(json.decode(response.body));
  }
}
