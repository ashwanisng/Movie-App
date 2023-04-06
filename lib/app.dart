import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_movie/model/movie_repository.dart';
import 'package:tmdb_movie/utils/theme/app_theme.dart';
import 'package:tmdb_movie/utils/values/env.dart';
import 'package:tmdb_movie/view/home/home_view.dart';
import 'package:tmdb_movie/view_model/latest_movie_bloc/bloc/latest_movie_bloc.dart';
import 'package:tmdb_movie/view_model/popular_movie/bloc/popular_movie_bloc.dart';
import 'package:tmdb_movie/view_model/search/bloc/search_movie_bloc.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _movieRepo = MovieRepository();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LatestMovieBloc(movieRepository: _movieRepo)
            ..add(LoadMoviesData()),
        ),
        BlocProvider(
          create: (context) => PopularMovieBloc(movieRepository: _movieRepo)
            ..add(
              const PopularMoviesData(),
            ),
        ),
        BlocProvider(
          create: (context) => SearchMovieBloc(movieRepository: _movieRepo),
        )
      ],
      child: MaterialApp(
        title: Env.title,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        home: const HomeView(),
      ),
    );
  }
}
