import 'package:film_browser/models/film.dart';
import 'package:film_browser/api.dart';
import 'package:meta/meta.dart';

class Repository{
  final Api api;

  Repository({@required this.api});

  Future<List<Film>> getPopularFilms(){
      return Film.mapTo(api
          .getPopularFilms()
          .asStream())
          .toList()
          .catchError((error) => handleError(error));
  }

  Future<List<Film>> getFilms(String query){
    return Film.mapTo(api
        .getFilms(query)
        .asStream())
        .toList()
        .catchError((error) => handleError(error));
  }

  Future<Film> getFilm(String id){
    return api
        .getFilm(id)
        .then((response) => Film.map(response))
        .catchError((error) => handleError(error));
  }

  handleError(error){
    print(error);
  }
}
