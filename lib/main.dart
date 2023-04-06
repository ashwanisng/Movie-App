import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_movie/app.dart';
import 'package:tmdb_movie/model/movie_repository.dart';
import 'package:tmdb_movie/view_model/latest_movie_bloc/bloc/latest_movie_bloc.dart';

void main() async {
  final _movieRepository = MovieRepository();
  runApp(
    // MultiBlocProvider(
    //   providers: [
    //     BlocProvider<LatestMovieBloc>(
    //       create: ((context) =>
    //           LatestMovieBloc(movieRepository: _movieRepository)),
    //     ),
    //   ],
    const App(),
    // ),
  );
}
