class Env {
  Env._privateConstructor();

  static const title = "TMDB Movie";
  static const baseURL = "http://127.0.0.1:8080/";

  static const imageBaseUrlW400 = "https://image.tmdb.org/t/p/w400";

  static const imageBaseUrlW500 = "https://image.tmdb.org/t/p/w500";

  static const imageBaseUrlW185 = "https://image.tmdb.org/t/p/w185";

  static const playStoreLink = "https://play.google.com/store/apps/details?id";
  static const appStoreLink = "https://apps.apple.com/us/app/starter/id";

  static const upComingMovieUrl =
      "https://api.themoviedb.org/3/movie/upcoming?api_key=909594533c98883408adef5d56143539&language=en-US&page=1";
  static const popularMovieUrl =
      "https://api.themoviedb.org/3/movie/popular?api_key=909594533c98883408adef5d56143539&language=en-US&page=1";

  static const movieTrailerUrl = "https://api.themoviedb.org/3/movie";
}
