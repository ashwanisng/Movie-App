part of 'latest_movie_bloc.dart';

@immutable
abstract class LatestMovieState extends Equatable {
  @override
  List<Object> get props => [];
}

class LatestMovieInitial extends LatestMovieState {
  LatestMovieInitial();
}

class LoadingState extends LatestMovieState {
  LoadingState();
}

class LatestMoviesList extends LatestMovieState {
  List<Movies>? moviesData;
  LatestMoviesList({
    this.moviesData,
  });
}
