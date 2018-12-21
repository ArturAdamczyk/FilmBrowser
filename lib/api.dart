import 'package:film_browser/models/film.dart';
import 'package:film_browser/config.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

abstract class Api{
  Future<List<FilmResponse>> getPopularFilms();
  Future<List<FilmResponse>> getFilms(String query);
  Future<FilmResponse> getFilm(String id);
}

class TestApi implements Api{
  @override
  Future<List<FilmResponse>> getPopularFilms(){
    return Future(() => [
      FilmResponse(name:"Maczeta 1"),
      FilmResponse(name:"Maczeta 2"),
      FilmResponse(name:"Maczeta 3")]);
  }
  @override
  Future<List<FilmResponse>> getFilms(String query){
    return Future(() => [
      FilmResponse(name:"Queried film 1"),
      FilmResponse(name:"Queried film 2")]);
  }
  @override
  Future<FilmResponse> getFilm(String id){
    return Future(() => FilmResponse(name:"Searched movie"));
  }
}

class WebApi implements Api{
  http.Client _client;

  @override
  Future<List<FilmResponse>> getPopularFilms() async{
    final response = await _client.get(Config.WEB_ADDRESS + "/" + Config.GET_POPULAR_FILMS);
    if (response.statusCode == 200) return compute(parseFilms, response.body);
    else throw Exception('Failed to load popular films');
  }

  @override
  Future<List<FilmResponse>> getFilms(String query) async{
    final response = await _client.get(Config.WEB_ADDRESS + "/" + Config.GET_FILMS + "/" + query);
    if (response.statusCode == 200) return compute(parseFilms, response.body);
    else throw Exception('Failed to load films');
  }

  @override
  Future<FilmResponse> getFilm(String id) async{
    final response = await _client.get(Config.WEB_ADDRESS + "/" + Config.GET_FILM + "/" + id);
    if (response.statusCode == 200) return compute(parseFilm, response.body);
    else throw Exception('Failed to load film');
  }

  List<FilmResponse> parseFilms(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<FilmResponse>((json) => FilmResponse.fromJson(json)).toList();
  }

  FilmResponse parseFilm(String responseBody) {
    return FilmResponse.fromJson(json.decode(responseBody));
  }

}