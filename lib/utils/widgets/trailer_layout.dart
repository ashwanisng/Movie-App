import 'package:flutter/material.dart';
import 'package:tmdb_movie/model/services/trailer_response.dart';

Widget trailerLayout(
    {required TrailerResponse data, required Orientation orientation}) {
  return GridView.builder(
      itemCount: data.trailer?.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          childAspectRatio: 16 / 10),
      itemBuilder: (BuildContext context, int index) {
        return trailerItem(data.trailer?[index]);
      });
}

trailerItem(Trailer? data) {
  return Column(
    children: <Widget>[
      Expanded(
        child: Container(
          margin: const EdgeInsets.all(5.0),
          color: Colors.grey,
          child: const Center(child: Icon(Icons.play_circle_filled)),
        ),
      ),
      Text(
        data?.name ?? "",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    ],
  );
}

Widget noTrailer() {
  return const Center(
    child: Text("No trailer available"),
  );
}
