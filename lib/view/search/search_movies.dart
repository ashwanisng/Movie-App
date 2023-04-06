import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_movie/model/movie_response.dart';
import 'package:tmdb_movie/utils/helper/debounce.dart';
import 'package:tmdb_movie/utils/widgets/movie_card.dart';
import 'package:tmdb_movie/utils/widgets/search_textfeild.dart';
import 'package:tmdb_movie/view/movie_details/movie_details.dart';
import 'package:tmdb_movie/view_model/search/bloc/search_movie_bloc.dart';

class SearchMovie extends StatefulWidget {
  const SearchMovie({Key? key}) : super(key: key);

  @override
  State<SearchMovie> createState() => _SearchMovieState();
}

class _SearchMovieState extends State<SearchMovie> {
  final TextEditingController _controller = TextEditingController();

  late SearchMovieBloc _searchMovieBloc;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    _searchMovieBloc = BlocProvider.of<SearchMovieBloc>(context);

    _searchMovieBloc.add(LoadSearchedMovie(""));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Platform.isAndroid
                        ? Icons.arrow_back
                        : CupertinoIcons.back)),
                Expanded(
                  child: SearchTextField(
                      fillColor: Colors.grey[900]!,
                      hintText: 'Search for a movie.',
                      searchCallback: (String value) => EasyDebounce.debounce(
                          'search',
                          const Duration(milliseconds: 300),
                          () => _searchMovieBloc.searchMovie(value)),
                      controller: _controller),
                ),
              ],
            ),
            Expanded(
              child: BlocBuilder<SearchMovieBloc, SearchMovieState>(
                  builder: (context, state) {
                if (state is SearchLoading) {
                  return const Center(
                      child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                  ));
                } else if (state is SearchSuccess) {
                  if (state.moviesData != null) {
                    return const Center(
                        child: Text(
                      'No Result Found',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ));
                  } else {
                    return searchResult(
                        searchList: state.moviesData ?? [],
                        orientation: orientation);
                  }
                } else if (state is SearchError) {
                  return const Center(
                    child: Text(
                      'Error in loading data!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget searchResult(
      {required List<Movies> searchList, required Orientation orientation}) {
    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 10.0, top: 20.0, bottom: 20.0),
          child: Text(
            'Top Results',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        GridView.builder(
          itemCount: searchList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: orientation == Orientation.portrait ? 3 : 6,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              childAspectRatio: 2 / 3),
          itemBuilder: (BuildContext context, int index) {
            return InkResponse(
              enableFeedback: true,
              child: MovieCard(url: searchList[index].posterPath ?? ''),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MovieDetail(
                    detail: searchList[index],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
