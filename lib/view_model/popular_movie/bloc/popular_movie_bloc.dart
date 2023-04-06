import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_movie/model/movie_repository.dart';
import 'package:tmdb_movie/model/movie_response.dart';

part 'popular_movie_event.dart';
part 'popular_movie_state.dart';

class PopularMovieBloc extends Bloc<PopularMovieEvent, PopularMovieState> {
  final MovieRepository _movieRepository;
  PopularMovieBloc({required MovieRepository movieRepository})
      : _movieRepository = movieRepository,
        super(PopularMovieInitial()) {
    on<PopularMoviesData>(_mapGetMoviesFeed);
  }

  _mapGetMoviesFeed(
      PopularMoviesData event, Emitter<PopularMovieState> emit) async {
    emit(const LoadingState());
    try {
      List<Movies>? data = await fetchData();

      if (data != null) {
        emit(LatestMoviesList(moviesData: data));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  fetchData() async {
    List<Movies>? data = await _movieRepository.getPopularMovies();

    if (data != null) {
      return data;
    }
  }
}
