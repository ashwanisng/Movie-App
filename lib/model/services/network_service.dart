import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_movie/model/movie_response.dart';
import 'package:tmdb_movie/model/services/trailer_response.dart';
import 'package:tmdb_movie/utils/values/constants.dart';
import 'package:tmdb_movie/utils/values/env.dart';

class NetworkService {
  late Dio _dio;

  NetworkService() {
    prepareRequest();
  }

  void prepareRequest() {
    BaseOptions dioOptions = BaseOptions(
      connectTimeout: const Duration(milliseconds: Timeouts.CONNECT_TIMEOUT),
      receiveTimeout: const Duration(milliseconds: Timeouts.RECEIVE_TIMEOUT),
      baseUrl: Env.baseURL,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
      headers: {'Accept': Headers.jsonContentType},
    );

    _dio = Dio(dioOptions);

    _dio.interceptors.clear();

    _dio.interceptors.add(LogInterceptor(
      error: true,
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
      logPrint: _printLog,
    ));
  }

  _printLog(Object object) => log(object.toString());

  Future<MovieResponse> getMovieFeed({
    required String path,
  }) async {
    late Response response;
    try {
      response = await _dio.get(path);
    } on Exception catch (error, stack) {
      // FirebaseCrashlytics.instance.recordError(error, stack);;
    }
    return MovieResponse.fromJson(response.data);
  }

  Future<TrailerResponse> fetchMovieTrailer({
    required String path,
  }) async {
    late Response response;
    try {
      response = await _dio.get(path);
    } on Exception catch (error, stack) {}
    return TrailerResponse.fromJson(response.data);
  }

  Future<MovieResponse> searchMovie({
    required String path,
  }) async {
    late Response response;
    try {
      response = await _dio.get(path);
    } on Exception catch (error, stack) {}
    return MovieResponse.fromJson(response.data);
  }
}
