import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_movie/model/movie_repository.dart';
import 'package:tmdb_movie/model/movie_response.dart';

part 'latest_movie_event.dart';
part 'latest_movie_state.dart';

class LatestMovieBloc extends Bloc<LatestMovieEvent, LatestMovieState> {
  final MovieRepository _movieRepository;

  List<Movies>? data;

  LatestMovieBloc({required MovieRepository movieRepository})
      : _movieRepository = movieRepository,
        super(LatestMovieInitial()) {
    on<LoadMoviesData>(_mapGetMoviesFeed);
  }

  _mapGetMoviesFeed(
      LoadMoviesData event, Emitter<LatestMovieState> emit) async {
    emit(LoadingState());
    try {
      List<Movies>? data = await _movieRepository.getUpcomingMovies();

      if (data != null) {
        emit(LatestMoviesList(moviesData: data));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
