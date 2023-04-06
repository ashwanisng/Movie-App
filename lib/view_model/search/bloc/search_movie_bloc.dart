import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_movie/model/movie_repository.dart';
import 'package:tmdb_movie/model/movie_response.dart';

part 'search_movie_event.dart';
part 'search_movie_state.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  final MovieRepository _movieRepository;
  SearchMovieBloc({required MovieRepository movieRepository})
      : _movieRepository = movieRepository,
        super(SearchMovieInitial()) {
    on<LoadSearchedMovie>(_mapSearchMovies);
  }

  _mapSearchMovies(
    LoadSearchedMovie event,
    Emitter<SearchMovieState> emit,
  ) async {
    emit(SearchLoading());
    try {
      List<Movies>? data = await searchMovie(event.query ?? "");
      if (data != null) {
        emit(SearchSuccess(moviesData: data));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  searchMovie(String queries) async {
    List<Movies>? data = await _movieRepository.searchMovie(queries);

    if (data != null) {
      return data;
    }
  }
}
