part of 'search_movie_bloc.dart';

abstract class SearchMovieEvent extends Equatable {
  const SearchMovieEvent();

  @override
  List<Object> get props => [];
}

class LoadSearchedMovie extends SearchMovieEvent {
  String? query;
  LoadSearchedMovie(
    this.query,
  );
}
