import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_movie/model/movie_repository.dart';
import 'package:tmdb_movie/model/movie_response.dart';
import 'package:tmdb_movie/model/services/trailer_response.dart';
import 'package:tmdb_movie/utils/theme/app_colors.dart';
import 'package:tmdb_movie/utils/values/env.dart';
import 'package:tmdb_movie/utils/widgets/shimmer.dart';
import 'package:tmdb_movie/utils/widgets/trailer_layout.dart';

class MovieDetail extends StatefulWidget {
  const MovieDetail({Key? key, required this.detail}) : super(key: key);

  final Movies detail;

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  final MovieRepository _movieRepository = MovieRepository();

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;

    var info = widget.detail;
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: 200.0,
                  floating: false,
                  pinned: true,
                  backgroundColor: AppColors.primaryColor,
                  elevation: 0.0,
                  flexibleSpace: FlexibleSpaceBar(
                      background: CachedNetworkImage(
                    imageUrl: Env.imageBaseUrlW500 + (info.posterPath ?? ''),
                    placeholder: (ctx, str) {
                      return shimmer(
                          size: MediaQuery.of(context).size,
                          height: 200,
                          radius: 0);
                    },
                    errorWidget: (ctx, str, dynamic) {
                      return const Icon(Icons.error);
                    },
                    fit: BoxFit.cover,
                  )),
                ),
              ];
            },
            body: ListView(
              physics: const BouncingScrollPhysics(),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(margin: const EdgeInsets.only(top: 5.0)),
                      Text(
                        info.title ?? 'Movie',
                        style: const TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 8.0, bottom: 8.0)),
                      Row(
                        children: <Widget>[
                          const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                          Container(
                            margin:
                                const EdgeInsets.only(left: 1.0, right: 1.0),
                          ),
                          Text(
                            info.voteAverage!.toStringAsFixed(1),
                            style: const TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                          Container(
                            margin:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                          ),
                          Text(
                            info.releaseDate ?? '-/-/-',
                            style: const TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ],
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 8.0, bottom: 8.0)),
                      Text(info.overview!),
                      Container(
                          margin: const EdgeInsets.only(top: 8.0, bottom: 8.0)),
                      const Text(
                        "Trailer",
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 8.0, bottom: 8.0)),
                      FutureBuilder(
                        future: _movieRepository
                            .fetchMovieTrailer(widget.detail.id!),
                        builder:
                            (context, AsyncSnapshot<TrailerResponse> snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data!.trailer != null) {
                              return trailerLayout(
                                  data: snapshot.data!,
                                  orientation: orientation);
                            } else {
                              return noTrailer();
                            }
                          } else if (snapshot.hasError) {
                            debugPrint("yoooo");
                            return noTrailer();
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.red),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
