part of 'latest_movie_bloc.dart';

@immutable
abstract class LatestMovieEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadMoviesData extends LatestMovieEvent {
  LoadMoviesData();
}
