import 'package:flutter/material.dart';
import 'package:tmdb_movie/model/movie_response.dart';
import 'package:tmdb_movie/model/services/network_service.dart';
import 'package:tmdb_movie/model/services/trailer_response.dart';
import 'package:tmdb_movie/utils/values/env.dart';

class MovieRepository {
  NetworkService controller = NetworkService();

  Future<List<Movies>?> getUpcomingMovies() async {
    List<Movies>? data;
    String url = Env.upComingMovieUrl;

    var response = await controller.getMovieFeed(path: url);

    if (response.movies != null) {
      data = response.movies;
    }
    return data;
  }

  Future<List<Movies>?> getPopularMovies() async {
    List<Movies>? data;
    String url = Env.popularMovieUrl;

    var response = await controller.getMovieFeed(path: url);

    if (response.movies != null) {
      data = response.movies;
    }
    return data;
  }

  Future<TrailerResponse> fetchMovieTrailer(int movieId) async {
    String url =
        "${Env.movieTrailerUrl}/$movieId/videos?api_key=fa0c92af3ea4daf346aace070bc25bf8&language=en-US";
    var response = await controller.fetchMovieTrailer(path: url);
    response.trailer?.forEach((element) {});

    return response;
  }

  Future<List<Movies>?> searchMovie(String query) async {
    List<Movies>? data;
    String url =
        "https://api.themoviedb.org/3/search/movie?api_key=fa0c92af3ea4daf346aace070bc25bf8&language=en-US&query=$query&page=1&include_adult=false";

    var response = await controller.searchMovie(path: url);

    if (response.movies != null) {
      data = response.movies;
    }
    return data;
  }
}
