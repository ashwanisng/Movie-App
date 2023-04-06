import 'package:flutter/material.dart';
import 'package:tmdb_movie/model/movie_response.dart';
import 'package:tmdb_movie/utils/widgets/movie_card.dart';
import 'package:tmdb_movie/view/movie_details/movie_details.dart';

Widget buildList(
    {required List<Movies>? movieList, required Orientation orientation}) {
  return GridView.builder(
    itemCount: movieList?.length,
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
        child: MovieCard(url: movieList![index].posterPath!),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => MovieDetail(
                detail: movieList[index],
              ),
            ),
          );
        },
      );
    },
  );
}
