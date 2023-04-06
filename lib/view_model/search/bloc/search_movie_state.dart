part of 'search_movie_bloc.dart';

abstract class SearchMovieState extends Equatable {
  const SearchMovieState();

  @override
  List<Object> get props => [];
}

class SearchMovieInitial extends SearchMovieState {}

class SearchLoading extends SearchMovieState {}

class SearchSuccess extends SearchMovieState {
  List<Movies>? moviesData;
  SearchSuccess({
    this.moviesData,
  });
}

class SearchError extends SearchMovieState {}
