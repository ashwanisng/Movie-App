import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_movie/utils/theme/app_colors.dart';
import 'package:tmdb_movie/utils/widgets/custom_app_bar.dart';
import 'package:tmdb_movie/utils/widgets/error_widget.dart';
import 'package:tmdb_movie/utils/widgets/movie_list.dart';
import 'package:tmdb_movie/utils/widgets/suggested_movie.dart';
import 'package:tmdb_movie/view_model/popular_movie/bloc/popular_movie_bloc.dart';

class PopularMovie extends StatelessWidget {
  const PopularMovie({super.key});

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: customAppBar(context),
        body: BlocListener<PopularMovieBloc, PopularMovieState>(
          // bloc: latestMovieBloc,
          listener: (context, state) {
            if (state is LoadingState) {}
          },
          child: BlocBuilder<PopularMovieBloc, PopularMovieState>(
            // bloc: latestMovieBloc,
            builder: (context, state) {
              if (state is LoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is LatestMoviesList) {
                return ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    suggestMovie(size, state.moviesData![0], context),
                    const SizedBox(height: 30),
                    buildList(
                        movieList: state.moviesData, orientation: orientation),
                  ],
                );
              } else {
                return errorWidget(size, context);
              }
            },
          ),
        ),
      ),
    );
  }
}
