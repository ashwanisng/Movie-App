part of 'popular_movie_bloc.dart';

abstract class PopularMovieState extends Equatable {
  const PopularMovieState();

  @override
  List<Object> get props => [];
}

class PopularMovieInitial extends PopularMovieState {}

class LoadingState extends PopularMovieState {
  const LoadingState();
}

class LatestMoviesList extends PopularMovieState {
  List<Movies>? moviesData;
  LatestMoviesList({
    this.moviesData,
  });
}
