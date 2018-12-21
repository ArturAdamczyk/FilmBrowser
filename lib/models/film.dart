
class Film{
    String name;
    String productionDate;
    String rating;
    String director;
    String description;
    Film({this.name="", this.productionDate="", this.rating="", this.director="", this.description=""});
    Film.map(FilmResponse response):
          name = response.name,
          productionDate = response.productionDate,
          rating = response.rating,
          director = response.director,
          description = response.description;

    static Stream<Film> mapTo(Stream stream) {
      return stream.map((convert) => convert.forEach((it) => Film.map(it)));
    }
}

class FilmResponse{
  String name;
  String productionDate;
  String rating;
  String director;
  String description;
  FilmResponse({this.name="", this.productionDate="", this.rating="", this.director="", this.description=""});

  factory FilmResponse.fromJson(Map<String, dynamic> json) {
    return FilmResponse(
      name: json['name'],
      productionDate: json['productionId'],
      rating: json['rating'],
      director: json['director'],
      description: json['description'],
    );
  }

}


